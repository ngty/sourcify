shared 'Proc#to_source from { ... } block (1.9.*)' do

  should 'handle simple (w label keys)' do
    (
      lambda {
        {a: 1, b: 2}
      }
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:hash, s(:lit, :a), s(:lit, 1), s(:lit, :b), s(:lit, 2)))
    )
  end

  should 'handle nested (w label keys)' do
    (
      lambda {
        {a: 1, b: {c: 3}}
      }
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:hash,
          s(:lit, :a),
          s(:lit, 1),
          s(:lit, :b),
          s(:hash, s(:lit, :c), s(:lit, 3))))
    )
  end

end
