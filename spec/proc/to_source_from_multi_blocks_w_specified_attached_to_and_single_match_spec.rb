require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...} & single match' do

  options = {:attached_to => :watever}

  should 'handle no nesting on same line' do
    b1 = lambda {|a| @x1+1 }; b2 = watever { @x1+2 }; b3 = lambda { @x1+3 }
    b2.should.be having_source('proc { @x1+2 }', options)
  end

  should 'handle single level nesting on same line' do
    b1 = lambda {|a| @x2+1 }; b2 = watever { lambda { @x2+2 } }
    b2.should.be having_source('proc { lambda { @x2+2 } }', options)
  end

  should 'handle multi level nesting on same line' do
    b2 = (lambda {|a| watever { lambda { @x3 } } }).call(1)
    b2.should.be having_source('proc { lambda { @x3 } }', options)
  end

end
