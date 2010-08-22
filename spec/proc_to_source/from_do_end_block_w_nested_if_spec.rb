require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested if)" do

  expected = %Q\
    proc do
      if aa then true ; end
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        if aa then true ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        if aa then true ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        if aa then true ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_code(expected)
  end

end
