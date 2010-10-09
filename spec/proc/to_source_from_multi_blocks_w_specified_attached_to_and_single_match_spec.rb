require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...} & single match' do

  options = {:attached_to => /^.*?(\W|)watever(\W)/}

  describe '>> wo nesting on same line' do

    should 'handle (all do...end blocks)' do
      b1 = lambda do |a| @x1+1 end; b2 = watever do @x1+2 end; b3 = lambda do @x1+3 end
      b2.should.be having_source('proc { @x1+2 }', options)
    end

    should 'handle (all {...} blocks)' do
      b1 = lambda {|a| @x2+1 }; b2 = watever { @x2+2 }; b3 = lambda { @x2+3 }
      b2.should.be having_source('proc { @x2+2 }', options)
    end

    should 'handle (mixed {...} w do...end blocks)' do
      b1 = lambda {|a| @x3+1 }; b2 = watever do @x3+2 end; b3 = lambda { @x3+3 }
      b2.should.be having_source('proc { @x3+2 }', options)
    end

    should 'handle (mixed do...end w {...} blocks)' do
      b1 = lambda do |a| @x4+1 end; b2 = watever { @x4+2 }; b3 = lambda do @x4+3 end
      b2.should.be having_source('proc { @x4+2 }', options)
    end

  end

  describe '>> w single level nesting on same line' do

    should 'handle (all do...end blocks)' do
      b1 = lambda do |a| @x1+1 end; b2 = watever do lambda do @x1+2 end end
      b2.should.be having_source('proc { lambda { @x1+2 } }', options)
    end

    should 'handle (all {...} blocks)' do
      b1 = lambda {|a| @x2+1 }; b2 = watever { lambda { @x2+2 } }
      b2.should.be having_source('proc { lambda { @x2+2 } }', options)
    end

    should 'handle (mixed {...} w do...end blocks)' do
      b1 = lambda {|a| @x3+1 }; b2 = watever do lambda { @x3+2 } end
      b2.should.be having_source('proc { lambda { @x3+2 } }', options)
    end

    should 'handle (mixed do...end w {...} blocks)' do
      b1 = lambda do |a| @x4+1 end; b2 = watever { lambda do @x4+2 end }
      b2.should.be having_source('proc { lambda { @x4+2 } }', options)
    end

  end

  describe '>> w multi level nesting on same line' do

    should 'handle (all do...end blocks)' do
      b1 = lambda do |a| watever do lambda do @x1 end end end
      (b2 = b1.call(1)).should.be having_source('proc { lambda { @x1 } }', options)
    end

    should 'handle (all {...} blocks)' do
      b1 = lambda {|a| watever { lambda { @x2 } } }
      (b2 = b1.call(1)).should.be having_source('proc { lambda { @x2 } }', options)
    end

    should 'handle (mixed {...} w do...end blocks)' do
      b1 = lambda {|a| watever do lambda { @x3 } end }
      (b2 = b1.call(1)).should.be having_source('proc { lambda { @x3 } }', options)
    end

    should 'handle (mixed do...end w {...} blocks)' do
      b1 = lambda do |a| watever { lambda do @x4 end } end
      (b2 = b1.call(1)).should.be having_source('proc { lambda { @x4 } }', options)
    end

  end

end
