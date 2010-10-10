require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested case)" do

  should 'handle simple' do
    (
      lambda do
        case @x1 when true then false end
      end
    ).should.be having_source(%Q\
      proc do
        case @x1 when true then false end
      end
    \)
  end

  should 'handle nested' do
    (
      lambda do
        case @x1
        when true
          case @x2 when false then true end
        end
      end
    ).should.be having_source(%Q\
      proc do
        case @x1
        when true
          case @x2 when false then true end
        end
      end
    \)
  end

end
