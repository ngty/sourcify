require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_sexp within IRB (from def..end block)" do

  class << self

    def irb_eval(string)
      irb_exec(string)[-1]
    end

    def equal_to(expected)
      lambda {|found| found == expected }
    end

  end

  should 'handle non var' do
    irb_eval(%(
      def m1; x; end
      method(:m1).to_sexp
    )).should.be equal_to(
      s(:defn, :m1, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

  should 'not handle local var' do
    irb_eval(%(
      x = :lx
      def m2; x; end
      method(:m2).to_sexp
    )).should.be equal_to(
      s(:defn, :m2, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

end
