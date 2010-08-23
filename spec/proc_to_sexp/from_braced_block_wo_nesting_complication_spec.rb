require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from { ... } block (wo nesting complication)" do

  expected = %Q\
    s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:ivar, :@x%s))
  \

  should 'handle watever(..) { ... }' do
    (
      watever(:a, :b, {:c => 1}) { @x1 }
    ).should.be having_sexp(expected%1)
  end

  should 'handle watever(..) \ { ... }' do
    (
      watever(:a, :b, {:c => 1}) \
        { @x2 }
    ).should.be having_sexp(expected%2)
  end

  should 'handle watever { ... }' do
    (
      watever { @x3 }
    ).should.be having_sexp(expected%3)
  end

  should 'handle watever \ { ... }' do
    (
      watever \
        { @x4 }
    ).should.be having_sexp(expected%4)
  end

  should 'handle lambda { ... }' do
    (
      lambda { @x5 }
    ).should.be having_sexp(expected%5)
  end

  should 'handle lambda \ { ... }' do
    (
      lambda \
        { @x6 }
    ).should.be having_sexp(expected%6)
  end

end
