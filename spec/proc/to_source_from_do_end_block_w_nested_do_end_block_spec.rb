require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested do ... end block)" do

  should 'handle simple' do
    (
      lambda do
        lambda do @x1 = 1 end
      end
    ).should.be having_source(%Q\
      proc do
        lambda { @x1 = 1 }
      end
    \)
  end

  should 'handle nested' do
    (
      lambda do
        lambda do
          lambda do @x1 = 1 end
        end
      end
    ).should.be having_source(%Q\
      proc do
        lambda do
          lambda { @x1 = 1 }
        end
      end
    \)
  end

end
