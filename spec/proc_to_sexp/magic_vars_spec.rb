require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp (magic vars)" do

  should 'handle __FILE__' do
    expected = s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:str, __FILE__))
    lambda { __FILE__ }.should.be having_sexp(expected)
  end

  should 'handle __LINE__' do
    expected = s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:lit, __LINE__.succ))
    lambda { __LINE__ }.should.be having_sexp(expected)
  end

end
