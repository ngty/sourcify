require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source w specified {:attached_to => ...} & single match (from define_method)' do

  before { @thing = Object.new }
  options = {:attached_to => :watever}

  should 'handle no nesting on same line' do
    b1 = lambda {|a| @x1+1 }; b2 = watever { @x1+2 }; b3 = lambda { @x1+3 }
    @thing.class.send(:define_method, :m1, &b2)
    @thing.method(:m1).should.be having_source('def m1; @x1+2; end', options)
  end

  should 'handle single level nesting on same line' do
    b1 = lambda {|a| @x2+1 }; b2 = watever { lambda { @x2+2 } }
    @thing.class.send(:define_method, :m2, &b2)
    @thing.method(:m2).should.be having_source('def m2; lambda { @x2+2 }; end', options)
  end

  should 'handle multi level nesting on same line' do
    b2 = (lambda {|a| watever { lambda { @x3 } } }).call(1)
    @thing.class.send(:define_method, :m3, &b2)
    @thing.method(:m3).should.be having_source('def m3; lambda { @x3 }; end', options)
  end

end
