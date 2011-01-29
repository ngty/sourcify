require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested until block)" do

  should 'handle w do' do
    (
      lambda do
        until true do @x1 = 1 end
      end
    ).should.be having_source(%Q\
      proc do
        until true do @x1 = 1 end
      end
    \)
  end

  should 'handle w \ do' do
    (
      lambda do
        until true \
          do @x1 = 2 end
      end
    ).should.be having_source(%Q\
      proc do
        until true do @x1 = 2 end
      end
    \)
  end

  should 'handle wo do (w newline)' do
    (
      lambda do
        until true
          @x1 = 3
        end
      end
    ).should.be having_source(%Q\
      proc do
        until true
          @x1 = 3
        end
      end
    \)
  end

  should 'handle wo do (w semicolon)' do
    (
      lambda do
        until true; @x1 = 4; end
      end
    ).should.be having_source(%Q\
      proc do
        until true
          @x1 = 4
        end
      end
    \)
  end

  should 'handle nested wo do within w do' do
    (
      lambda do
        until true do
          until true; @x1 = 5; end
        end
      end
    ).should.be having_source(%Q\
      proc do
        until true do
          until true
            @x1 = 5
          end
        end
      end
    \)
  end

  should 'handle nested wo do within wo do' do
    (
      lambda do
        until true
          until true; @x1 = 6; end
        end
      end
    ).should.be having_source(%Q\
      proc do
        until true
          until true
            @x1 = 6
          end
        end
      end
    \)
  end

  should 'handle nested w do within wo do' do
    (
      lambda do
        until true
          until true do @x1 = 7 end
        end
      end
    ).should.be having_source(%Q\
      proc do
        until true
          until true
            @x1 = 7
          end
        end
      end
    \)
  end

  should 'handle nested w do within w do' do
    (
      lambda do
        until true do
          until true do @x1 = 8 end
        end
      end
    ).should.be having_source(%Q\
      proc do
        until true
          until true
            @x1 = 8
          end
        end
      end
    \)
  end

  should 'handle simple modifier' do
    (
      lambda do
        @x1 = 9 until true
      end
    ).should.be having_source(%Q\
      proc do
        @x1 = 9 until true
      end
    \)
  end

  should 'handle block within modifier' do
    (
      lambda do
        @x1 = 10 until (
          until true do @x1 = 10 end
        )
      end
    ).should.be having_source(%Q\
      proc do
        @x1 = 10 until (
          until true do @x1 = 10 end
        )
      end
    \)
  end

  should 'handle modifier within block' do
    (
      lambda do
        until true
          @x1 = 11 until true
        end
      end
    ).should.be having_source(%Q\
      proc do
        until true
          @x1 = 11 until true
        end
      end
    \)
  end

  should 'handle modifier w trailing backslash' do
    (
      lambda do
        @x1 = 9 \
          until true
      end
    ).should.be having_source(%Q\
      proc do
        @x1 = 9 until true
      end
    \)
  end

end
