require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source (from def ... end block)" do
  describe "w nested while block" do

    should 'handle w do' do
      def m1
        while true do @x1 = 1 end
      end
      method(:m1).should.be having_source(%(
        def m1
          while true do @x1 = 1 end
        end
      ))
    end

    should 'handle w \ do' do
      def m2
        while true \
          do @x1 = 2 end
      end
      method(:m2).should.be having_source(%(
        def m2
          while true do @x1 = 2 end
        end
      ))
    end

    should 'handle wo do (w newline)' do
      def m3
        while true
          @x1 = 3
        end
      end
      method(:m3).should.be having_source(%(
        def m3
          while true
            @x1 = 3
          end
        end
      ))
    end

    should 'handle wo do (w semicolon)' do
      def m4
        while true; @x1 = 4; end
      end
      method(:m4).should.be having_source(%(
        def m4
          while true
            @x1 = 4
          end
        end
      ))
    end

    should 'handle nested wo do within w do' do
      def m5
        while true do
          while true; @x1 = 5; end
        end
      end
      method(:m5).should.be having_source(%(
        def m5
          while true do
            while true
              @x1 = 5
            end
          end
        end
      ))
    end

    should 'handle nested wo do within wo do' do
      def m6
        while true
          while true; @x1 = 6; end
        end
      end
      method(:m6).should.be having_source(%(
        def m6
          while true
            while true
              @x1 = 6
            end
          end
        end
      ))
    end

    should 'handle nested w do within wo do' do
      def m7
        while true
          while true do @x1 = 7 end
        end
      end
      method(:m7).should.be having_source(%(
        def m7
          while true
            while true
              @x1 = 7
            end
          end
        end
      ))
    end

    should 'handle nested w do within w do' do
      def m8
        while true do
          while true do @x1 = 8 end
        end
      end
      method(:m8).should.be having_source(%(
        def m8
          while true
            while true
              @x1 = 8
            end
          end
        end
      ))
    end

    should 'handle simple modifier' do
      def m9
        @x1 = 9 while true
      end
      method(:m9).should.be having_source(%(
        def m9
          @x1 = 9 while true
        end
      ))
    end

    should 'handle block within modifier' do
      def m10
        @x1 = 10 while (
          while true do @x1 = 10 end
        )
      end
      method(:m10).should.be having_source(%(
        def m10
          @x1 = 10 while (
            while true do @x1 = 10 end
          )
        end
      ))
    end

    should 'handle modifier within block' do
      def m11
        while true
          @x1 = 11 while true
        end
      end
      method(:m11).should.be having_source(%(
        def m11
          while true
            @x1 = 11 while true
          end
        end
      ))
    end

    should 'handle modifier w trailing backslash' do
      def m12
        @x1 = 9 \
          while true
      end
      method(:m12).should.be having_source(%(
        def m12
          @x1 = 9 while true
        end
      ))
    end

  end
end
