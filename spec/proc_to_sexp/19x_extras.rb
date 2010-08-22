shared 'Proc#to_sexp from { ... } block (w nested hash (w label-key))' do

  expected =
    s(:iter,
      s(:call, nil, :lambda, s(:arglist)),
      nil,
      s(:block,
        s(:lasgn,
          :a,
          s(:hash,
            s(:lit, :a),
            s(:lit, 1),
            s(:lit, :b),
            s(:hash, s(:lit, :c), s(:lit, 2)))),
            s(:array,
              s(:call, nil, :xx, s(:arglist)),
              s(:call, nil, :x, s(:arglist)),
              s(:ivar, :@x),
              s(:cvar, :@@x),
              s(:gvar, :$x))))

  should 'handle watever(..) { ... } (label-key)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        a = {a: 1, b: {c: 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected)
  end

  should 'handle watever { ... } (label-key)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        a = {a: 1, b: {c: 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected)
  end

  should 'handle lambda { ... } (label-key)' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        a = {a: 1, b: {c: 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected)
  end

end
