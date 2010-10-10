require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...} & no match' do

  options = {:attached_to => :forever}

  if has_parsetree?

    should 'handle no nesting on same line' do
      b1 = lambda do |a| @x1+1 end; b2 = lambda do @x1+2 end; b3 = lambda do @x1+3 end
      b2.should.be having_source('proc { @x1+2 }', options)
    end

    should 'handle single level nesting on same line' do
      b1 = lambda do |a| @x2+1 end; b2 = lambda do lambda do @x2+2 end end
      b2.should.be having_source('proc { lambda { @x2+2 } }', options)
    end

    should 'handle multi level nesting on same line' do
      b2 = (lambda do |a| lambda do lambda do @x3 end end end).call(1)
      b2.should.be having_source('proc { lambda { @x3 } }', options)
    end

  else

    error = Sourcify::NoMatchingProcError

    should "raise #{error} w no nesting on same line" do
      b1 = lambda {|a| @x }; b2 = watever { @x }; b3 = lambda { @x }
      lambda { b2.to_source(options) }.should.raise(error)
    end

    should "raise #{error} w single level nesting on same line" do
      b1 = lambda {|a| @x }; b2 = watever { lambda { @x } }
      lambda { b2.to_source(options) }.should.raise(error)
    end

    should "raise #{error} w multi level nesting on same line" do
      b2 = (lambda {|a| watever { lambda { @x } } }).call(1)
      lambda { b2.to_source(options) }.should.raise(error)
    end

  end

end
