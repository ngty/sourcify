require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source (from define_method)' do
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
      pry_eval(%\
        thing = Object.new
        blk = lambda { x }
        thing.class.send(:define_method, :m1, &blk)
        thing.method(:m1).to_source
      \).should.be equal_to(%(
        def m1
          x
        end
      ))
    end

    should 'handle upward scroll' do
      pry_eval(%Q(
        thing = Object.new
        b1 = lambda { x1 }
        b2 = lambda { x2 }
        thing.class.send(:define_method, :m1, &b1)
        thing.class.send(:define_method, :m2, &b2)
        thing.method(:m1).to_source
        thing.method(:m2).to_source
        [A[A
      )).should.be equal_to(%(
        def m1
          x1
        end
      ))
    end
  
  end
end
