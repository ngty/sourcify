require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source w specified {:ignore_nested => ...} (for defind_method)' do

  before { @thing = Object.new }
  options = {:ignore_nested => true}

  if has_parsetree?
    # TODO: Should we support parsetree ??
  else

    should "raise Sourcify::MultipleMatchingProcsPerLineError w no nesting on same line" do
      b1 = lambda {|a| @x1+1 }; b2 = lambda { @x1+2 }; b3 = lambda { @x1+3 }
      @thing.class.send(:define_method, :m1, &b2)
      lambda { @thing.method(:m1).to_source(options) }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
    end

    should "handle w single level nesting on same line" do
      b1 = lambda {|a| @x2+1 }; b2 = lambda { lambda { @x2+3 } }
      @thing.class.send(:define_method, :m2, &b2)
      @thing.method(:m2).should.be having_source(%(
        def m2
          lambda { @x2+3 }
        end
      ), options)
    end

    should "raise Sourcify::NoMatchingProcError w multi level nesting on same line (w outermost having diff arity)" do
      b2 = (lambda {|a| lambda { lambda { @x3 } } }).call(1)
      @thing.class.send(:define_method, :m3, &b2)
      lambda { @thing.method(:m3).to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
    end

  end

end
