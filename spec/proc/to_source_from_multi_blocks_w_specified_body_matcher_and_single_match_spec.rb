require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified body matcher & single match' do

  matcher = lambda {|code| code =~ /^(.*\W|)def\W/ }

  should 'handle no nesting on same line' do
    b1 = lambda {|a| @x1+1 }; b2 = lambda { @x1+2 }; b3 = lambda { def aa; end }
    b3.should.be having_source('proc { def aa; end }', &matcher)
  end

  should 'handle single level nesting on same line' do
    b1 = lambda {|a| @x2+1 }; b2 = lambda { def bb; end; lambda { @x2+3 } }
    b2.should.be having_source('proc { def bb; end; lambda { @x2+3 } }', &matcher)
  end

  should 'handle multi level nesting on same line' do
    b2 = (lambda {|a| lambda { def cc; end; lambda { @x3+3 } } }).call(1)
    b2.should.be having_source('proc { def cc; end; lambda { @x3+3 } }', &matcher)
  end

end
