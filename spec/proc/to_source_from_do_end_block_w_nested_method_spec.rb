require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested method)" do

  expected = %Q\
    proc do
      def aa; a = "ia"; end
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        def aa; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        def aa; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        def aa; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

end
