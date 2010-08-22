require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested class)" do

  expected1 = %Q\
    proc do
      class AA; a = "ia"; end
      [xx, x, @x, @@x, $x]
    end
  \

  expected2 = %Q\
    proc do
      class AA < Object; a = "ia"; end
      [xx, x, @x, @@x, $x]
    end
  \

  expected3 = %Q\
    proc do
      class << x; a = "ia"; end
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        class AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever(..) do ... end (as subclass)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        class AA < Object; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle watever(..) do ... end (as singleton)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        class << x; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected3)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        class AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever do ... end (as subclass)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        class AA < Object; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle watever do ... end (as singleton)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        class << x; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected3)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        class AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle lambda do ... end (as subclass)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        class AA < Object; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle lambda do ... end (as singleton)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        class << x; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected3)
  end

end
