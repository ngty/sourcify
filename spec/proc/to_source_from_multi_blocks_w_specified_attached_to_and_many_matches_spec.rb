require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...} & single match' do

  options = {:attached_to => :lambda}

  if has_parsetree?

    should 'handle no nesting on same line' do
      b1 = lambda {|a| @x1+1 }; b2 = lambda { @x1+2 }; b3 = lambda { @x1+3 }
      b2.should.be having_source('proc { @x1+2 }', options)
    end

    should 'handle single level nesting on same line' do
      b1 = lambda {|a| @x2+1 }; b2 = lambda { lambda { @x2+2 } }
      b2.should.be having_source('proc { lambda { @x2+2 } }', options)
    end

    should 'handle multi level nesting on same line' do
      b2 = (lambda {|a| lambda { lambda { @x3 } } }).call(1)
      b2.should.be having_source('proc { lambda { @x3 } }', options)
    end

  else

    error = Sourcify::MultipleMatchingProcsPerLineError

    should "raise #{error} w no nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
      lambda { b2.to_source(options) }.should.raise(error)
    end

    should "raise #{error} w single level nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { lambda { @x } }
      lambda { b2.to_source(options) }.should.raise(error)
    end

    should "raise #{error} w multi level nesting on same line" do
      b2 = (lambda {|a| lambda { lambda { @x } } }).call(1)
      lambda { b2.to_source(options) }.should.raise(error)
    end

  end

end
