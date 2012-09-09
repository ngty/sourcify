require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source (from def..end block)' do
  describe 'within PRY' do

    class << self

      def pry_eval(string)
        pry_exec(string)[-1]
      end

      def equal_to(expected)
        lambda {|found| normalize_code(found) == normalize_code(expected) }
      end

    end

    should 'handle' do
      pry_eval(%(
        def m1; x; end
        method(:m1).to_source
      )).should.be equal_to(%(
        def m1
          x
        end
      ))
    end

  end
end
