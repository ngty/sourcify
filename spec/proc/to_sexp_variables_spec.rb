require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp (variables)" do

  should 'handle non var' do
    expected = s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:call, nil, :x, s(:arglist)))
    lambda { x }.should.be having_sexp(expected)
  end

  should 'handle local var' do
    x, expected = 'lx', s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:lvar, :x))
    lambda { x }.should.be having_sexp(expected)
  end

  should 'handle instance var' do
    @x, expected = 'ix', s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:ivar, :@x))
    lambda { @x }.should.be having_sexp(expected)
  end

  should 'handle class var' do
    @@x, expected = 'cx', s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:cvar, :@@x))
    lambda { @@x }.should.be having_sexp(expected)
  end

  should 'handle global var' do
    $x, expected = 'gx', s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:gvar, :$x))
    lambda { $x }.should.be having_sexp(expected)
  end

  should 'handle magic var __FILE__' do
    expected = s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:str, __FILE__))
    lambda { __FILE__ }.should.be having_sexp(expected)
  end

  should 'handle magic var __LINE__' do
    expected = s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:lit, __LINE__ + 1))
    lambda { __LINE__ }.should.be having_sexp(expected)
  end

end
