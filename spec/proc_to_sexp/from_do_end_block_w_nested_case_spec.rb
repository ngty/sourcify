require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested case)" do

  expected =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:case,
          s(:call, nil, :aa, s(:arglist)),
          s(:when, s(:array, s(:true)), s(:call, nil, :bb, s(:arglist))),
          nil),
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
        case aa ; when true then bb ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle watever do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        case aa ; when true then bb ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

  should 'handle lambda do ... end' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        case aa ; when true then bb ; end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected)
  end

end
