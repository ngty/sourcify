require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (wo nesting complication)" do

  expected = %|proc { [xx, x, @x, @@x, $x] }|

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever(..) \ do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever \ do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(expected)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(expected)
  end

  should 'handle lambda \ do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda \
        do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(expected)
  end

end
