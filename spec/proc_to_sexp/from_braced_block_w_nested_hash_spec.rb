require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from { ... } block (w nested hash)" do

  expected =
    s(:iter,
      s(:call, nil, :proc, s(:arglist)),
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
              s(:lvar, :x),
              s(:ivar, :@x),
              s(:cvar, :@@x),
              s(:gvar, :$x))))

  should 'handle watever(..) { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever(:a, :b, {:c => 1}) {
        a = {:a => 1, :b => {:c => 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected)
  end

  should 'handle watever { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      watever {
        a = {:a => 1, :b => {:c => 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected)
  end

  should 'handle lambda { ... }' do
    x, @x, @@x, $x = 'lx', 'ix', 'cx', 'gx'
    (
      lambda {
        a = {:a => 1, :b => {:c => 2}}
        [xx, x, @x, @@x, $x]
      }
    ).should.be having_sexp(expected)
  end

  if RUBY_VERSION.include?('1.9.')
    require File.join(File.dirname(__FILE__), '19x_extras')
    behaves_like 'Proc#to_sexp from { ... } block (w nested hash (w label-key))'
  end

end
