require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested while block)" do

  expected1 = %Q\
    proc do
      while(true)
        a = "ia"
      end
      [xx, x, @x, @@x, $x]
    end
  \

  expected2 = %Q\
    proc do
      a = 'ia' while true
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        while(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever(..) do ... end (w \ do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        while(true) \
          do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever(..) do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        while true
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        while(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever do ... end (w \ do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        while(true) \
          do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        while true
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle lambda do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        while(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle lambda do ... end (w \ do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        while(true) \
          do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle lambda do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        while true
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever(..) do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        a = 'ia' while true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle watever do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        a = 'ia' while true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle lambda do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        a = 'ia' while true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

end
