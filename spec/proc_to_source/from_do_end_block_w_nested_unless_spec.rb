require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested unless)" do

  expected1 = %Q\
    proc do
      unless aa then true ; end
      [xx, x, @x, @@x, $x]
    end
  \

  expected2 = %Q\
    proc do
      a = 'ia' unless true
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        unless aa then true ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        unless aa then true ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        unless aa then true ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected1)
  end

  should 'handle watever(..) do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        a = 'ia' unless true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle watever do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        a = 'ia' unless true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

  should 'handle lambda do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        a = 'ia' unless true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected2)
  end

end
