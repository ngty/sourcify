require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested lambda do ... end)" do

  expected = %Q\
    proc do
      lambda { a = "ia" }
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

end
