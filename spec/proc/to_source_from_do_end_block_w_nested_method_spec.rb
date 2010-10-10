require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested method)" do

  should 'handle simple' do
    (
      lambda do
        def aa; x = 1; end
      end
    ).should.be having_source(%Q\
      proc do
        def aa; x = 1; end
      end
    \)
  end

  should 'handle nested' do
    (
      lambda do
        def aa
          def bb; x = 2; end
        end
      end
    ).should.be having_source(%Q\
      proc do
        def aa
          def bb; x = 2; end
        end
      end
    \)
  end

end
