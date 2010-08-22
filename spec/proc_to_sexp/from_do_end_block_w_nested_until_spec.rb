require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested until block)" do

  expected1 =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:until, s(:true), s(:lasgn, :a, s(:str, "ia")), true),
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
        s(:until, s(:true), s(:lasgn, :a, s(:str, "ia")), true),
             s(:array,
               s(:call, nil, :xx, s(:arglist)),
               s(:lvar, :x),
               s(:ivar, :@x),
               s(:cvar, :@@x),
               s(:gvar, :$x))))

  should 'handle watever(..) do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        until(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
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
    ).should.be having_sexp(expected1)
  end

  should 'handle watever do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        until(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
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
    ).should.be having_sexp(expected1)
  end

  should 'handle lambda do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        until(true) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
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
    ).should.be having_sexp(expected1)
  end

  should 'handle watever(..) do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        a = 'ia' until true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

  should 'handle watever do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        a = 'ia' until true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

  should 'handle lambda do ... end (as modifier)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        a = 'ia' until true
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

end
