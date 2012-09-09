require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_sexp (from def..end block)' do
  describe 'within PRY' do

    class << self

      def pry_eval(string)
        pry_exec(string)[-1]
      end

      def equal_to(expected)
        lambda {|found| found == expected }
      end

    end

    should 'handle non var' do
      pry_eval(%(
        def m1; x; end
        method(:m1).to_sexp
      )).should.be equal_to(
        s(:defn, :m1, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
      )
    end

    should 'not handle local var' do
      pry_eval(%(
        x = :lx
        def m2; x; end
        method(:m2).to_sexp
      )).should.be equal_to(
        s(:defn, :m2, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
      )
    end

  end
end
