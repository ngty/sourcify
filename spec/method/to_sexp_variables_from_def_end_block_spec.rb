require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_sexp variables (from def..end block)" do

  should 'handle non var' do
    def m1; x; end
    method(:m1).should.be having_sexp(
      s(:defn, :m1, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

  should 'not handle local var' do
    x = 'lx';
    def m2; x; end
    method(:m2).should.be having_sexp(
      s(:defn, :m2, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

  should 'handle instance var' do
    @x = 'ix'
    def m3; @x; end
    method(:m3).should.be having_sexp(
      s(:defn, :m3, s(:args), s(:scope, s(:block, s(:ivar, :@x))))
    )
  end

  should 'handle class var' do
    @@x = 'cx'
    def m4; @@x; end
    method(:m4).should.be having_sexp(
      s(:defn, :m4, s(:args), s(:scope, s(:block, s(:cvar, :@@x))))
    )
  end

  should 'handle global var' do
    $x = 'gx'
    def m5; $x; end
    method(:m5).should.be having_sexp(
      s(:defn, :m5, s(:args), s(:scope, s(:block, s(:gvar, :$x))))
    )
  end

end
