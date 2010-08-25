require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'Proc#to_sexp from multi blocks w single match' do

  expected = "s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:ivar, :@x%s))"

  should 'skip non-matching (all do...end blocks)' do
    (
      b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end; b2
    ).should.be having_sexp(expected%1)
  end

  should 'skip non-matching (all {...} blocks)' do
    (
      b1 = lambda {|a| @x2 }; b2 = lambda { @x2 }; b2
    ).should.be having_sexp(expected%2)
  end

  should 'skip non-matching (mixed {...} with do...end blocks)' do
    (
      b1 = lambda {|a| @x3 }; b2 = lambda do @x3 end; b2
    ).should.be having_sexp(expected%3)
  end

  should 'skip non-matching (mixed do...end with {...} blocks)' do
    (
      b1 = lambda do |a| @x4 end; b2 = lambda { @x4 }; b2
    ).should.be having_sexp(expected%4)
  end

end
