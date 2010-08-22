require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from { ... } block (w nested { ... } block)" do

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

  should 'handle watever(..) { ... } (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        watever { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected1)
  end

  should 'handle watever(..) { ... } (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        watever(:a, :b, {:c => 1}) { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected2)
  end

  should 'handle watever { ... } (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        watever { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected1)
  end

  should 'handle watever { ... } (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        watever(:a, :b, {:c => 1}) { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected2)
  end

  should 'handle lambda { ... } (simple)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        watever { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected1)
  end

  should 'handle lambda { ... } (complex)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        watever(:a, :b, {:c => 1}) { a = 'ia' }
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected2)
  end

end
