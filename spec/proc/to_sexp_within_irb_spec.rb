require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_sexp within IRB" do

  class << self

    def irb_eval(string)
      irb_exec(string)[-1]
    end

    def equal_to(expected)
      lambda {|found| found == expected }
    end

  end

  should 'handle non var' do
    expected = s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:call, nil, :x, s(:arglist)))
    irb_eval('lambda { x }.to_sexp').should.be equal_to(expected)
  end

  should 'handle local var' do
    expected = s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:lvar, :x))
    irb_eval(%Q(
      x = 'lx'
      lambda { x }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'handle class_eval scoped local var' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:iter,
          s(:call, s(:const, :Object), :class_eval, s(:arglist)),
          s(:lasgn, :x),
          s(:lasgn, :y, s(:lvar, :x))))
    irb_eval(%Q(
      x = 1
      lambda { Object.class_eval {|x| y = x } }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'handle instance_eval scoped local var' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:iter,
          s(:call, s(:str, "aa"), :instance_eval, s(:arglist)),
          s(:lasgn, :x),
          s(:lasgn, :y, s(:lvar, :x))))
    irb_eval(%Q(
      x = 1
      lambda { 'aa'.instance_eval {|x| y = x } }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'handle define_method scoped local var' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:iter,
          s(:call,
            s(:const, :Object),
            :send,
            s(:arglist, s(:lit, :define_method), s(:lit, :aa))),
            s(:lasgn, :x),
            s(:lasgn, :y, s(:lvar, :x))))
    irb_eval(%Q(
      x = 1
      lambda { Object.send(:define_method, :aa) {|x| y = x } }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'not handle class scoped local var (simple)' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:class, :AA, nil, s(:scope, s(:lasgn, :y, s(:call, nil, :x, s(:arglist))))))
    irb_eval(%Q(
      x = 1
      lambda { class AA ; y = x ; end }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'not handle class scoped local var (w inheritance)' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:class,
          :AA,
          s(:const, :Object),
          s(:scope, s(:lasgn, :y, s(:call, nil, :x, s(:arglist))))))
    irb_eval(%Q(
      x = 1
      lambda { class AA < Object; y = x ; end }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'not handle class scoped local var (w singleton)' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:sclass,
          s(:str, "AA"),
          s(:scope, s(:lasgn, :y, s(:call, nil, :x, s(:arglist))))))
    irb_eval(%Q(
      x = 1
      lambda { class << 'AA'; y = x ; end }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'not handle module scoped local var' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:module, :AA, s(:scope, s(:lasgn, :y, s(:call, nil, :x, s(:arglist))))))
    irb_eval(%Q(
      x = 1
      lambda { module AA ; y = x ; end }.to_sexp
    )).should.be equal_to(expected)
  end

  should 'not handle method scoped local var' do
    expected =
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:defn,
          :aa,
          s(:args),
          s(:scope, s(:block, s(:lasgn, :y, s(:call, nil, :x, s(:arglist)))))))
    irb_eval(%Q(
      x = 1
      lambda { def aa ; y = x ; end }.to_sexp
    )).should.be equal_to(expected)
  end

end
