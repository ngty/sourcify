require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_sexp w specified {:strip_enclosure => ...} (from define_method)' do

  before { @thing = Object.new }

  # NOTE: This is a potential bug !! Strictly speaking, when we create any
  # method via Module#define_method, the scope is not block. Anyway, we're
  # keeping things simple for now & see how things go .. which may or may
  # not matter.

  describe '>> w true' do

    options = {:strip_enclosure => true}

    should 'strip enclosing proc wo arg' do
      blk = lambda { a+b }
      @thing.class.send(:define_method, :m1, &blk)
      @thing.method(:m1).should.be having_sexp(
        s(:scope,
          s(:block,
            s(:call,
              s(:call, nil, :a, s(:arglist)),
              :+,
              s(:arglist, s(:call, nil, :b, s(:arglist)))))),
        options
      )
    end

    should 'strip enclosing proc w arg' do
      blk = lambda{|a| a+b }
      @thing.class.send(:define_method, :m2, &blk)
      @thing.method(:m2).should.be having_sexp(
        s(:scope,
          s(:block,
            s(:call,
              s(:lvar, :a),
              :+,
              s(:arglist, s(:call, nil, :b, s(:arglist)))))),
        options
      )
    end

  end

  describe '>> w false' do

    options = {:strip_enclosure => false}

    should 'not strip enclosing proc wo arg' do
      blk = lambda { a+b }
      @thing.class.send(:define_method, :m3, &blk)
      @thing.method(:m3).should.be having_sexp(
        s(:defn,
          :m3,
          s(:args),
          s(:scope,
            s(:block,
              s(:call,
                s(:call, nil, :a, s(:arglist)),
                :+,
                s(:arglist, s(:call, nil, :b, s(:arglist))))))),
        options
      )
    end

    should 'not strip enclosing proc w arg' do
      blk = lambda{|a| a+b }
      @thing.class.send(:define_method, :m4, &blk)
      @thing.method(:m4).should.be having_sexp(
        s(:defn,
          :m4,
          s(:args, :a),
          s(:scope,
             s(:block,
                 s(:call, s(:lvar, :a), :+, s(:arglist, s(:call, nil, :b, s(:arglist))))))),
        options
      )
    end

  end

end
