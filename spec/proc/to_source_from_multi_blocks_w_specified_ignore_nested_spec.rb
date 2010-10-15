require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:ignore_nested => ...}' do

  options = {:ignore_nested => true}

  if has_parsetree?

    should 'handle no nesting on same line' do
      b1 = lambda {|a| @x1+1 }; b2 = lambda { @x1+2 }; b3 = lambda { @x1+3 }
      b2.should.be having_source('proc { @x1+2 }', options)
    end

    should 'handle single level nesting on same line' do
      b1 = lambda {|a| @x2+1 }; b2 = lambda { lambda { @x2+2 } }
      b2.should.be having_source('proc { lambda { @x2+2 } }', options)
    end

    should 'handle multi level nesting on same line (w outermost having diff arity)' do
      b2 = (lambda {|a| lambda { lambda { @x3 } } }).call(1)
      b2.should.be having_source('proc { lambda { @x3 } }', options)
    end

  else

    should "raise Sourcify::MultipleMatchingProcsPerLineError w no nesting on same line" do
      b1 = lambda {|a| @x1+1 }; b2 = lambda { @x1+2 }; b3 = lambda { @x1+3 }
      lambda { b2.to_source(options) }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
    end

    should "handle w single level nesting on same line" do
      b1 = lambda {|a| @x2+1 }; b2 = lambda { lambda { @x2+3 } }
      b2.should.be having_source('proc { lambda { @x2+3 } }', options)
    end

    should "raise Sourcify::NoMatchingProcError w multi level nesting on same line (w outermost having diff arity)" do
      b2 = (lambda {|a| lambda { lambda { @x3 } } }).call(1)
      lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
    end

  end

end
