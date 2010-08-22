require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from { ... } block (w nested lambda{...})" do

  expected = %Q\
    proc do
      lambda { a = "ia" }
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        lambda { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected)
  end

  should 'handle watever { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        lambda { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected)
  end

  should 'handle lambda { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        lambda { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected)
  end

end
