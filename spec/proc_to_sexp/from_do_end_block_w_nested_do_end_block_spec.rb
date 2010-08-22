require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested do ... end block)" do

  expected1 =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
      nil,
      s(:block,
        s(:iter,
          s(:call, nil, :watever, s(:arglist)),
          nil,
          s(:lasgn, :a, s(:str, "ia"))),
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
        s(:iter,
          s(:call,
            nil,
            :watever,
            s(:arglist, s(:lit, :a), s(:lit, :b), s(:hash, s(:lit, :c), s(:lit, 1)))),
            nil,
            s(:lasgn, :a, s(:str, "ia"))),
            s(:array,
              s(:call, nil, :xx, s(:arglist)),
              s(:lvar, :x),
              s(:ivar, :@x),
              s(:cvar, :@@x),
              s(:gvar, :$x))))

  should 'handle watever(..) do ... end (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        watever do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
  end

  should 'handle watever(..) do ... end (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) do
        watever(:a, :b, {:c => 1}) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

  should 'handle watever do ... end (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        watever do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
  end

  should 'handle watever do ... end (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever do
        watever(:a, :b, {:c => 1}) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

  should 'handle lambda do ... end (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        watever do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected1)
  end

  should 'handle lambda do ... end (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda do
        watever(:a, :b, {:c => 1}) do a = 'ia' end
        [xx, x, @x, @@x, $x]
      end
    ).should.be having_sexp(expected2)
  end

end
