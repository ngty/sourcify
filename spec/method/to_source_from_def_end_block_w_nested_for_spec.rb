require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source (from def ... end block)" do
  describe "w nested for block" do

    should 'handle w do' do
      def m1
        for x1 in [1,2] do x1 end
      end
      method(:m1).should.be having_source(%(
        def m1
          for x1 in [1,2] do x1 end
        end
      ))
    end

    should 'handle w \ do' do
      def m2
        for x2 in [1,2] \
          do x2 end
      end
      method(:m2).should.be having_source(%(
        def m2
          for x2 in [1,2] do x2 end
        end
      ))
    end

    should 'handle wo do (w newline)' do
      def m3
        for x3 in [1,2]
          x3
        end
      end
      method(:m3).should.be having_source(%(
        def m3
          for x3 in [1,2]
            x3
          end
        end
      ))
    end

    should 'handle wo do (w semicolon)' do
      def m4
        for x4 in [1,2]; x4; end
      end
      method(:m4).should.be having_source(%(
        def m4
          for x4 in [1,2]
            x4
          end
        end
      ))
    end

    should 'handle nested wo do within w do' do
      def m5
        for x1 in [1,2] do
          for x2 in [1,2]
            x2
          end
        end
      end
      method(:m5).should.be having_source(%(
        def m5
          for x1 in [1,2] do
            for x2 in [1,2]
              x2
            end
          end
        end
      ))
    end

    should 'handle nested wo do within wo do' do
      def m6
        for x1 in [2,3]
          for x2 in [2,3]
            x2
          end
        end
      end
      method(:m6).should.be having_source(%(
        def m6
          for x1 in [2,3] do
            for x2 in [2,3]
              x2
            end
          end
        end
      ))
    end

    should 'handle nested w do within wo do' do
      def m7
        for x1 in [3,4]
          for x2 in [3,4] do x2 end
        end
      end
      method(:m7).should.be having_source(%(
        def m7
          for x1 in [3,4]
            for x2 in [3,4] do x2 end
          end
        end
      ))
    end

    should 'handle nested w do within w do' do
      def m8
        for x1 in [4,5] \
          do for x2 in [4,5] do x2 end
        end
      end
      method(:m8).should.be having_source(%(
        def m8
          for x1 in [4,5]
            for x2 in [4,5] do x2 end
          end
        end
      ))
    end

  end
end
