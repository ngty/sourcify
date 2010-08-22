require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested module)" do

  expected = %Q\
    proc do
      module AA; a = "ia"; end
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        module AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        module AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        module AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected)
  end

end
