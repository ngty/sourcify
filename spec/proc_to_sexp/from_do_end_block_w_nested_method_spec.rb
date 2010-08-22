require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested method)" do

  expected =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:defn, :aa, s(:args), s(:scope, s(:block, s(:lasgn, :a, s(:str, "ia"))))),
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
        def aa; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        def aa; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        def aa; a = 'ia'; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

end
