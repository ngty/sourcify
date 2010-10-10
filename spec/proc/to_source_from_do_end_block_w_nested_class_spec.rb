require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested class)" do

  should 'handle simple' do
    (
      lambda do
        class AA
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_source(%Q\
      proc do
        class AA
          def aa
            @x1 = 1
          end
        end
      end
    \)
  end

  should 'handle inheritance' do
    (
      lambda do
        class AA < Object
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_source(%Q\
      proc do
        class AA < Object
          def aa
            @x1 = 1
          end
        end
      end
    \)
  end

  should 'handle singleton' do
    (
      lambda do
        class << 'AA'
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_source(%Q\
      proc do
        class << 'AA'
          def aa
            @x1 = 1
          end
        end
      end
    \)
  end

  should 'handle nested' do
    (
      lambda do
        class AA
          class BB
            def bb
              @x1 = 1
            end
          end
        end
      end
    ).should.be having_source(%Q\
      proc do
        class AA
          class BB
            def bb
              @x1 = 1
            end
          end
        end
      end
    \)
  end

end
