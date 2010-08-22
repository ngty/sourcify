require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested class)" do

  expected1 =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:class, :AA, nil, s(:scope, s(:lasgn, :a, s(:str, "ia")))),
        s(:array,
          s(:call, nil, :xx, s(:arglist)),
          s(:lvar, :x),
          s(:ivar, :@x),
          s(:cvar, :@@x),
          s(:gvar, :$x))))

  expected2 =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:class, :AA, s(:const, :Object), s(:scope, s(:lasgn, :a, s(:str, "ia")))),
        s(:array,
          s(:call, nil, :xx, s(:arglist)),
          s(:lvar, :x),
          s(:ivar, :@x),
          s(:cvar, :@@x),
          s(:gvar, :$x))))

  expected3 =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:sclass, s(:lvar, :x), s(:scope, s(:lasgn, :a, s(:str, "ia")))),
        s(:array,
          s(:call, nil, :xx, s(:arglist)),
          s(:lvar, :x),
          s(:ivar, :@x),
          s(:cvar, :@@x),
          s(:gvar, :$x))))

  should 'handle watever(..) do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        class AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
  end

  should 'handle watever(..) do ... end (as subclass)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        class AA < Object; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

  should 'handle watever(..) do ... end (as singleton)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        class << x; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected3)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        class AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
  end

  should 'handle watever do ... end (as subclass)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        class AA < Object; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

  should 'handle watever do ... end (as singleton)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        class << x; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected3)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        class AA; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
  end

  should 'handle lambda do ... end (as subclass)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        class AA < Object; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

  should 'handle lambda do ... end (as singleton)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        class << x; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected3)
  end

end
