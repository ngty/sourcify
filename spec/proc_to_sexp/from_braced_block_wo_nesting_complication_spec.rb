require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from { ... } block (wo nesting complication)" do

  expected =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:array,
        s(:call, nil, :xx, s(:arglist)),
        s(:lvar, :x),
        s(:ivar, :@x),
        s(:cvar, :@@x),
        s(:gvar, :$x)))

  should 'handle watever(..) { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) { [xx, x, @x, @@x, $x] }
    ).should.be having_sexp(expected)
  end

  should 'handle watever(..) \ { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_sexp(expected)
  end

  should 'handle watever { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever { [xx, x, @x, @@x, $x] }
    ).should.be having_sexp(expected)
  end

  should 'handle watever \ { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_sexp(expected)
  end

  should 'handle lambda { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda { [xx, x, @x, @@x, $x] }
    ).should.be having_sexp(expected)
  end

  should 'handle lambda \ { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda \
        { [xx, x, @x, @@x, $x] }
    ).should.be having_sexp(expected)
  end

end
