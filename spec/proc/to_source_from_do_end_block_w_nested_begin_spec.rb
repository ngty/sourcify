require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested begin)" do

  should 'handle simple' do
    (
      lambda do
        begin @x1 = 1 end
      end
    ).should.be having_source(%Q\
      proc do
        begin @x1 = 1 end
      end
    \)
  end

  should 'handle nested' do
    (
      lambda do
        begin
          @x1 = 1
          begin @x2 = 2 end
        end
      end
    ).should.be having_source(%Q\
      proc do
        begin
          @x1 = 1
          begin @x2 = 2 end
        end
      end
    \)
  end

end
