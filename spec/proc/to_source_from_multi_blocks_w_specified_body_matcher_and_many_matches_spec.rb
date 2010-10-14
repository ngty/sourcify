require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...} & single match' do

  matcher = lambda {|code| code =~ /^(.*\W|)def\W/ }

  if has_parsetree?

    should 'handle no nesting on same line' do
      b1 = lambda {|a| @x1+1 }; b2 = lambda { @x1+2 }; b3 = lambda { @x1+3 }
      b2.should.be having_source('proc { @x1+2 }', &matcher)
    end

    should 'handle single level nesting on same line' do
      b1 = lambda {|a| @x2+1 }; b2 = lambda { lambda { @x2+2 } }
      b2.should.be having_source('proc { lambda { @x2+2 } }', &matcher)
    end

    should 'handle multi level nesting on same line' do
      b2 = (lambda {|a| lambda { lambda { @x3 } } }).call(1)
      b2.should.be having_source('proc { lambda { @x3 } }', &matcher)
    end

  else

    error = Sourcify::MultipleMatchingProcsPerLineError

    should "raise #{error} w no nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { def a1; end }; b3 = lambda { def a2; end }
      lambda { b2.to_source(&matcher) }.should.raise(error)
    end

    should "raise #{error} w single level nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { lambda { def bb; end } }
      lambda { b2.to_source(&matcher) }.should.raise(error)
    end

    should "raise #{error} w multi level nesting on same line" do
      b2 = (lambda {|a| lambda { lambda { def cc; end } } }).call(1)
      lambda { b2.to_source(&matcher) }.should.raise(error)
    end

  end

end
