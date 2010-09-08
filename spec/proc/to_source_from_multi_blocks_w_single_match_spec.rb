require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'Proc#to_source from multi blocks w single match' do

  expected = 'proc { @x%s }'

  describe 'wo nesting on same line' do

    should 'skip non-matching (all do...end blocks)' do
      (
        b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end; b2
      ).should.be having_source(expected%1)
    end

    should 'skip non-matching (all {...} blocks)' do
      (
        b1 = lambda {|a| @x2 }; b2 = lambda { @x2 }; b2
      ).should.be having_source(expected%2)
    end

    should 'skip non-matching (mixed {...} with do...end blocks)' do
      (
        b1 = lambda {|a| @x3 }; b2 = lambda do @x3 end; b2
      ).should.be having_source(expected%3)
    end

    should 'skip non-matching (mixed do...end with {...} blocks)' do
      (
        b1 = lambda do |a| @x4 end; b2 = lambda { @x4 }; b2
      ).should.be having_source(expected%4)
    end

  end

  describe 'w single level nesting on same line' do

    should 'skip non-matching (all do...end blocks)' do
      (
        b1 = lambda do |a| lambda do @x1 end end
        b2 = b1.call(1) # returns the inner proc
      ).should.be having_source(expected%1)
    end

    should 'skip non-matching (all {...} blocks)' do
      (
        b1 = lambda {|a| lambda { @x2 } }
        b2 = b1.call(1) # returns the inner proc
      ).should.be having_source(expected%2)
    end

    should 'skip non-matching (mixed {...} with do...end blocks)' do
      (
        b1 = lambda {|a| lambda do @x3 end }
        b2 = b1.call(1) # returns the inner proc
      ).should.be having_source(expected%3)
    end

    should 'skip non-matching (mixed do...end with {...} blocks)' do
      (
        b1 = lambda do |a| lambda { @x4 } end
        b2 = b1.call(1) # returns the inner proc
      ).should.be having_source(expected%4)
    end

  end

  describe 'w multi level nesting on same line' do

    should 'skip non-matching (all do...end blocks)' do
      (
        b1 = lambda do |a| lambda do |a| b2 = lambda do @x1 end end end
        b2 = b1.call(1).call(1) # returns the inner-most proc
      ).should.be having_source(expected%1)
    end

    should 'skip non-matching (all {...} blocks)' do
      (
        b1 = lambda {|a| lambda {|a| b2 = lambda { @x2 } } }
        b2 = b1.call(1).call(1) # returns the inner-most proc
      ).should.be having_source(expected%2)
    end

    should 'skip non-matching (mixed {...} with do...end blocks)' do
      (
        b1 = lambda {|a| lambda do |a| b2 = lambda do @x3 end end }
        b2 = b1.call(1).call(1) # returns the inner-most proc
      ).should.be having_source(expected%3)
    end

    should 'skip non-matching (mixed do...end with {...} blocks)' do
      (
        b1 = lambda do |a| lambda do |a| lambda { @x4 } end end
        b2 = b1.call(1).call(1) # returns the inner-most proc
      ).should.be having_source(expected%4)
    end

  end

end
