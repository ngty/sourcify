require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from { ... } block (w nested hash)" do

  expected1 = %Q\
    proc do
      a = {:a => 1, :b => {:c => 2}}
      [xx, x, @x, @@x, $x]
    end
  \

  expected2 = %Q\
    proc do
      a = {a: 1, b: {c: 2}}
      [xx, x, @x, @@x, $x]
    end
  \

  should 'handle watever(..) { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        a = {:a => 1, :b => {:c => 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected1)
  end

  should 'handle watever { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        a = {:a => 1, :b => {:c => 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected1)
  end

  should 'handle lambda { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        a = {:a => 1, :b => {:c => 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_same_code_as(expected1)
  end

  if RUBY_VERSION.include?('1.9.')
    require File.join(File.dirname(__FILE__), '19x_extras')
    behaves_like 'Proc#to_source from { ... } block (w nested hash (w label-key))'
  end

end
