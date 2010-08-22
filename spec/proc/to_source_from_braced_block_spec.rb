require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from { ... } block" do

  proc_code1 = %|proc { [xx, x, @x, @@x, $x] }|
  proc_code2 = %|proc {\n lambda { a = "ia" }\n [xx, x, @x, @@x, $x] }|

  should 'handle watever(..) { ... } (wo nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever(..) { ... } (w nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle watever(..) \ { ... } (wo nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever(..) \ { ... } (w nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        {
          lambda do a = 'ia' end
          [xx, x, @x, @@x, $x]
        }
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle watever { ... } (wo nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever { ... } (w nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        lambda do a = 'ia' end
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(proc_code2)
  end

  should 'handle watever \ { ... } (wo nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever \ { ... } (w nested { ... })' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        {
          lambda do a = 'ia' end
          [xx, x, @x, @@x, $x]
        }
    ).should.be having_same_code_as(proc_code2)
  end

end
