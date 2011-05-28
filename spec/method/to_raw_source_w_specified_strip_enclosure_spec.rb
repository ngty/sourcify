require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_raw_source w specified {:strip_enclosure => ...}' do

  describe '>> w true' do

    options = {:strip_enclosure => true}

    should 'strip enclosing method wo arg' do
      def m1
        a = 1
        # i should stay !!
      end
      method(:m1).should.be having_raw_source(%(
        a = 1
        # i should stay !!
      ), options)
    end

    should 'strip enclosing method w arg' do
      def m2(a)
        a = 1
        # i should stay !!
      end
      method(:m2).should.be having_raw_source(%(
        a = 1
        # i should stay !!
      ), options)
    end

  end

  describe '>> w false' do

    options = {:strip_enclosure => false}

    should 'not strip enclosing method wo arg' do
      def m3
        a = 1
        # i should stay !!
      end
      method(:m3).should.be having_raw_source(%(
        def m3
          a = 1
          # i should stay !!
        end
      ), options)
    end

    should 'not strip enclosing method w arg' do
      def m4(a)
        a = 1
        # i should stay !!
      end
      method(:m4).should.be having_raw_source(%(
        def m4
          a = 1
          # i should stay !!
        end
      ), options)
    end

  end

end
