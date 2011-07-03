require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_sexp variables (from define_method))" do

  before do
    @thing = Object.new
  end

  should 'handle non var' do
    blk = lambda { x }
    @thing.class.send(:define_method, :m1, &blk)
    @thing.method(:m1).should.be having_sexp(
      s(:defn, :m1, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

  should 'not handle local var' do
    # NOTE: This can be a potential bug, cos we purposely ignore the local
    # var captured in the proc's binding ... anyway, we see how things go
    # (eg. maybe nobody would ever care abt it)
    x, blk = 'lx', lambda { x }
    @thing.class.send(:define_method, :m2, &blk)
    @thing.method(:m2).should.be having_sexp(
      s(:defn, :m2, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

  should 'handle instance var' do
    @x, blk = 'ix', lambda { @x }
    @thing.class.send(:define_method, :m3, &blk)
    method(:m3).should.be having_sexp(
      s(:defn, :m3, s(:args), s(:scope, s(:block, s(:ivar, :@x))))
    )
  end

  should 'handle class var' do
    @@x, blk = 'cx', lambda { @@x }
    @thing.class.send(:define_method, :m4, &blk)
    method(:m4).should.be having_sexp(
      s(:defn, :m4, s(:args), s(:scope, s(:block, s(:cvar, :@@x))))
    )
  end

  should 'handle global var' do
    $x, blk = 'gx', lambda { $x }
    @thing.class.send(:define_method, :m5, &blk)
    method(:m5).should.be having_sexp(
      s(:defn, :m5, s(:args), s(:scope, s(:block, s(:gvar, :$x))))
    )
  end

end
