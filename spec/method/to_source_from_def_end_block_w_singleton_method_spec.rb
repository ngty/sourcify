require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source (from def ... end block)' do
  describe 'w singleton method' do

    should 'strip object' do
      thing = Object.new
      def m
        @x1 = 1
      end
      method(:m).should.be having_source(%(
        def m
          @x1 = 1
        end
      ))
    end

  end
end
