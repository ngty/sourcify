require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_sexp w specified {:strip_enclosure => ...}' do

  describe '>> w true' do

    options = {:strip_enclosure => true}

    should 'strip enclosing proc wo arg' do
      lambda { a+b }.should.be having_sexp(
        s(:call,
          s(:call, nil, :a, s(:arglist)),
          :+,
          s(:arglist, s(:call, nil, :b, s(:arglist)))),
        options
      )
    end

    should 'strip enclosing proc w arg' do
      lambda {|a| a+b }.should.be having_sexp(
        s(:call,
          s(:lvar, :a),
          :+,
          s(:arglist, s(:call, nil, :b, s(:arglist)))),
        options
      )
    end

  end

  describe '>> w false' do

    options = {:strip_enclosure => false}

    should 'not strip enclosing proc wo arg' do
      lambda { a+b }.should.be having_sexp(
        s(:iter,
          s(:call, nil, :proc, s(:arglist)),
          nil,
          s(:call,
            s(:call, nil, :a, s(:arglist)),
            :+,
            s(:arglist, s(:call, nil, :b, s(:arglist))))),
        options
      )
    end

    should 'not strip enclosing proc w arg' do
      lambda {|a| a+b }.should.be having_sexp(
        s(:iter,
          s(:call, nil, :proc, s(:arglist)),
          s(:lasgn, :a),
          s(:call, s(:lvar, :a), :+, s(:arglist, s(:call, nil, :b, s(:arglist))))),
        options
      )
    end

  end

end
