require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source (from define_method)' do
  describe 'w specified body matcher & single match' do

    before { @thing = Object.new }
    matcher = lambda {|code| code =~ /^(.*\W|)alert\W/ }

    should 'handle no nesting on same line' do
      b1 = lambda {|a| @x1+1 }; b2 = lambda { @x1+2 }; b3 = lambda { alert(1) }
      @thing.class.send(:define_method, :m1, &b3)
      @thing.method(:m1).should.be having_source('def m1; alert(1); end', &matcher)
    end

    should 'handle single level nesting on same line' do
      b1 = lambda {|a| @x2+1 }; b2 = lambda { alert(1); lambda { @x2+3 } }
      @thing.class.send(:define_method, :m2, &b2)
      @thing.method(:m2).should.be having_source('def m2; alert(1); lambda { @x2+3 }; end', &matcher)
    end

    should 'handle multi level nesting on same line' do
      b2 = (lambda {|a| lambda { alert(1); lambda { @x3+3 } } }).call(1)
      @thing.class.send(:define_method, :m3, &b2)
      @thing.method(:m3).should.be having_source('def m3; alert(1); lambda { @x3+3 }; end', &matcher)
    end

  end
end
