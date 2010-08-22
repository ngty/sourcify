require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested until block)" do

  expected1 = %|proc {\n until(true) \n a = "ia" end\n  [xx, x, @x, @@x, $x] }|
  expected2 = %|proc {\n a = 'ia' until true\n  [xx, x, @x, @@x, $x] }|

  should 'handle watever(..) do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        until(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever(..) do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        until true
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever(..) \ do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        do
          until(true) do a = 'ia' end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever(..) \ do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        do
          until true
            a = 'ia'
          end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        until(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        until true
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever \ do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        do
          until(true) do a = 'ia' end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever \ do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        do
          until true
            a = 'ia'
          end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle lambda do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        until(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle lambda do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        until true
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle lambda \ do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda \
        do
          until(true) do a = 'ia' end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle lambda \ do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda \
        do
          until true
            a = 'ia'
          end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever(..) do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        a = 'ia' until true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected2)
  end

  should 'handle watever do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        a = 'ia' until true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected2)
  end

  should 'handle lambda do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        a = 'ia' until true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(expected2)
  end

end
