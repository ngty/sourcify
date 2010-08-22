require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from { ... } block (w nested { ... } block)" do

  expected1 = %Q\
    proc do
      watever { a = "ia" }
      [xx, x, @x, @@x, $x]
    end
  \

  expected2 = %Q\
    proc do
      watever(:a, :b, {:c => 1}) { a = "ia" }
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) { ... } (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        watever { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever(..) { ... } (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        watever(:a, :b, {:c => 1}) { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected2)
  end

  should 'handle watever { ... } (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        watever { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever { ... } (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        watever(:a, :b, {:c => 1}) { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected2)
  end

  should 'handle lambda { ... } (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        watever { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected1)
  end

  should 'handle lambda { ... } (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        watever(:a, :b, {:c => 1}) { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected2)
  end

end
