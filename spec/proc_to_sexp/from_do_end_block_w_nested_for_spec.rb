require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested for block)" do

  expected =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:for,
          s(:array, s(:lit, 1), s(:lit, 2)),
          s(:lasgn, :i),
          s(:lasgn, :a, s(:str, "ia"))),
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
        for i in [1,2] do a = "ia" end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle watever(..) do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        for i in [1,2]
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle watever do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        for i in [1,2] do a = "ia" end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle watever do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        for i in [1,2]
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle lambda do ... end (w do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        for i in [1,2] do a = "ia" end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle lambda do ... end (wo do)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        for i in [1,2]
          a = 'ia'
        end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

end
