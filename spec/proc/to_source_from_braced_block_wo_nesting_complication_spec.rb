require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from { ... } block (wo nesting complication)" do

  proc_code1 = %|proc { [xx, x, @x, @@x, $x] }|
  proc_code2 = %|proc {\n lambda { a = "ia" }\n [xx, x, @x, @@x, $x] }|

  should 'handle watever(..) { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever(..) \ { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle watever \ { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle lambda { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

  should 'handle lambda \ { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_same_code_as(proc_code1)
  end

end
