require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source (from def ... end block)" do
  describe "w nested unless" do

    should 'handle simple block' do
      def m1
        unless @x1 then @x1 = 1 end
      end
      method(:m1).should.be having_source(%(
        def m1
          unless @x1 then @x1 = 1 end
        end
      ))
    end

    should 'handle nested block' do
      def m2
        unless @x1
          unless @x2 then @x2 = 1 end
        end
      end
      method(:m2).should.be having_source(%(
        def m2
          unless @x1
            unless @x2 then @x2 = 1 end
          end
        end
      ))
    end

    should 'handle simple modifier' do
      def m3
        @x1 = 1 unless true
      end
      method(:m3).should.be having_source(%(
        def m3
          @x1 = 1 unless true
        end
      ))
    end

    should 'handle block within modifier' do
      def m4
        @x1 = 1 unless (unless @x1 then true end)
      end
      method(:m4).should.be having_source(%(
        def m4
          @x1 = 1 unless (unless @x1 then true end)
        end
      ))
    end

    should 'handle modifier within block' do
      def m5
        unless @x1
          @x1 = 1 unless @x2
        end
      end
      method(:m5).should.be having_source(%(
        def m5
          unless @x1
            @x1 = 1 unless @x2
          end
        end
      ))
    end

    should 'handle modifier w trailing backslash' do
      def m6
        @x1 = 1 \
          unless true
      end
      method(:m6).should.be having_source(%(
        def m6
          @x1 = 1 unless true
        end
      ))
    end

  end
end
