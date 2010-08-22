require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested for block)" do

  expected = %Q\
    proc do
      for i in [1,2] do a = "ia" end
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        for i in [1,2] do a = "ia" end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever(..) do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        for i in [1,2]
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        for i in [1,2] do a = "ia" end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        for i in [1,2]
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle lambda do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        for i in [1,2] do a = "ia" end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

  should 'handle lambda do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        for i in [1,2]
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected)
  end

end
