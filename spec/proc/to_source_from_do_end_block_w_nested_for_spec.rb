require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested for block)" do

  should 'handle w do' do
    (
      lambda do
        for x1 in [1,2] do x1 end
      end
    ).should.be having_source(%Q\
      proc do
        for x1 in [1,2] do x1 end
      end
    \)
  end

  should 'handle w \ do' do
    (
      lambda do
        for x2 in [1,2] \
          do x2 end
      end
    ).should.be having_source(%Q\
      proc do
        for x2 in [1,2] do x2 end
      end
    \)
  end

  should 'handle wo do (w newline)' do
    (
      lambda do
        for x3 in [1,2]
          x3
        end
      end
    ).should.be having_source(%Q\
      proc do
        for x3 in [1,2]
          x3
        end
      end
    \)
  end

  should 'handle wo do (w semicolon)' do
    (
      lambda do
        for x4 in [1,2]; x4; end
      end
    ).should.be having_source(%Q\
      proc do
        for x4 in [1,2]
          x4
        end
      end
    \)
  end

  should 'handle nested wo do within w do' do
    (
      lambda do
        for x1 in [1,2] do
          for x2 in [1,2]
            x2
          end
        end
      end
    ).should.be having_source(%Q\
      proc do
        for x1 in [1,2] do
          for x2 in [1,2]
            x2
          end
        end
      end
    \)
  end

  should 'handle nested wo do within wo do' do
    (
      lambda do
        for x1 in [2,3]
          for x2 in [2,3]
            x2
          end
        end
      end
    ).should.be having_source(%Q\
      proc do
        for x1 in [2,3] do
          for x2 in [2,3]
            x2
          end
        end
      end
    \)
  end

  should 'handle nested w do within wo do' do
    (
      lambda do
        for x1 in [3,4]
          for x2 in [3,4] do x2 end
        end
      end
    ).should.be having_source(%Q\
      proc do
        for x1 in [3,4]
          for x2 in [3,4] do x2 end
        end
      end
    \)
  end

  should 'handle nested w do within w do' do
    (
      lambda do
        for x1 in [4,5] \
          do for x2 in [4,5] do x2 end
        end
      end
    ).should.be having_source(%Q\
      proc do
        for x1 in [4,5]
          for x2 in [4,5] do x2 end
        end
      end
    \)
  end

end
