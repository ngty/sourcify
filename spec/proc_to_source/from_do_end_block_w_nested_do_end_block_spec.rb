require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested do ... end block)" do

  expected1 = %Q\
    proc do
      watever { a = "ia" }
      [xx, x, @x, @@x, $x]
    end
  \

  expected2 = %Q\
    proc do
      watever(:a, :b, {:c => 1}) { a = "ia" }
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        watever do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever(..) do ... end (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        watever(:a, :b, {:c => 1}) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle watever do ... end (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        watever do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever do ... end (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        watever(:a, :b, {:c => 1}) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle lambda do ... end (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        watever do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle lambda do ... end (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        watever(:a, :b, {:c => 1}) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

end
