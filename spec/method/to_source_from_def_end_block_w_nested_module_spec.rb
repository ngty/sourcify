require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source (from def ... end block)" do
  describe "w nested module" do

    class AA; end

    should 'handle simple' do
      def m1
        class << AA
          module BB
            def aa
              @x1 = 1
            end
          end
        end
      end
      method(:m1).should.be having_source(%(
        def m1
          class << AA
            module BB
              def aa
                @x1 = 1
              end
            end
          end
        end
      ))
    end

    should 'handle nested' do
      def m2
        class << AA
          module BB
            module CC
              def bb
                @x1 = 1
              end
            end
          end
        end
      end
      method(:m2).should.be having_source(%(
        def m2
          class << AA
            module BB
              module CC
                def bb
                  @x1 = 1
                end
              end
            end
          end
        end
      ))
    end

  end
end
