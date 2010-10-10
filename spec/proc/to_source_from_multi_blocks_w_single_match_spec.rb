require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source from multi blocks w single match' do

  should 'skip non-matching w no nesting on same line' do
    b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end
    b2.should.be having_source('proc { @x1 }')
  end

  should 'skip non-matching w single level nesting on same line' do
    b2 = (lambda {|a| lambda { @x2 } }).call(1)
    b2.should.be having_source('proc { @x2 }')
  end

  should 'skip non-matching w multi level nesting on same line' do
    b2 = (lambda {|a| lambda {|a| b2 = lambda { @x3 } } }).call(1).call(1)
    b2.should.be having_source('proc { @x3 }')
  end

end
