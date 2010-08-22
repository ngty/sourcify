require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block" do

  proc_code1 = %|proc { [xx, x, @x, @@x, $x] }|
  proc_code2 = %|proc {\n lambda { a = "ia" }\n [xx, x, @x, @@x, $x] }|

  should 'handle watever(..) do ... end (wo nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever(..) do ... end (w nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle watever(..) \ do ... end (wo nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever(..) \ do ... end (w nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        do
          lambda do a = 'ia' end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle watever do ... end (wo nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever do ... end (w nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle watever \ do ... end (wo nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever \ do ... end (w nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        do
          lambda do a = 'ia' end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle lambda do ... end (wo nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle lambda do ... end (w nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle lambda \ do ... end (wo nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda \
        do [xx, x, @x, @@x, $x] end
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle lambda \ do ... end (w nested do ... end)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda \
        do
          lambda do a = 'ia' end
          [xx, x, @x, @@x, $x]
        end
    ).should.be having_same_code_as(proc_code2)
  end

end
