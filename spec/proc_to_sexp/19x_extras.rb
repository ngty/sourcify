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

shared 'Proc#to_sexp from multi blocks w many matches spec (1.9.*)' do

  # Need this line since the parser file is dynamically required, otherwise we will get
  # undefined constant error
  require 'to_source/proc/parser19'

  should 'raise ToSource::Proc::Parser19::AmbiguousMatchError (all do...end blocks)' do
    lambda {
      (
        b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end; b3 = lambda do @x1 end ; b2
      ).to_sexp
    }.should.raise(ToSource::Proc::Parser19::AmbiguousMatchError)
  end

  should 'raise ToSource::Proc::Parser19::AmbiguousMatchError (all {...} blocks)' do
    lambda {
      (
        b1 = lambda {|a| @x2 }; b2 = lambda { @x2 }; b3 = lambda { @x2 } ; b2
      ).to_sexp
    }.should.raise(ToSource::Proc::Parser19::AmbiguousMatchError)
  end

  should 'raise ToSource::Proc::Parser19::AmbiguousMatchError (mixed {...} w do...end blocks)' do
    lambda {
      (
        b1 = lambda {|a| @x3 }; b2 = lambda do @x3 end; b3 = lambda { @x4 } ; b2
      ).to_sexp
    }.should.raise(ToSource::Proc::Parser19::AmbiguousMatchError)
  end

  should 'raise ToSource::Proc::Parser19::AmbiguousMatchError (mixed do...end w {...} blocks)' do
    lambda {
      (
        b1 = lambda do |a| @x4 end; b2 = lambda { @x4 }; b3 = lambda do @x4 end ; b2
      ).to_sexp
    }.should.raise(ToSource::Proc::Parser19::AmbiguousMatchError)
  end

end
