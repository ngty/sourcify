require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested if)" do

  should 'handle simple block' do
    (
      lambda do
        if @x1 then @x1 = 1 end
      end
    ).should.be having_source(%Q\
      proc do
        if @x1 then @x1 = 1 end
      end
    \)
  end

  should 'handle nested block' do
    (
      lambda do
        if @x1
          if @x2 then @x2 = 1 end
        end
      end
    ).should.be having_source(%Q\
      proc do
        if @x1
          if @x2 then @x2 = 1 end
        end
      end
    \)
  end

  should 'handle simple modifier' do
    (
      lambda do
        @x1 = 1 if true
      end
    ).should.be having_source(%Q\
      proc do
        @x1 = 1 if true
      end
    \)
  end

  should 'handle block within modifier' do
    (
      lambda do
        @x1 = 1 if (if @x1 then true end)
      end
    ).should.be having_source(%Q\
      proc do
        @x1 = 1 if (if @x1 then true end)
      end
    \)
  end

  should 'handle modifier w trailing backslash' do
    (
      lambda do
        @x1 = 1 \
          if true
      end
    ).should.be having_source(%Q\
      proc do
        @x1 = 1 if true
      end
    \)
  end

  should 'handle modifier within block' do
    (
      lambda do
        if @x1
          @x1 = 1 if @x2
        end
      end
    ).should.be having_source(%Q\
      proc do
        if @x1
          @x1 = 1 if @x2
        end
      end
    \)
  end

end
