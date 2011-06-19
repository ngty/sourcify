require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source from #define_method w single blocks and many matches' do

  before do
    @thing = Object.new
  end

  describe 'w do...end block' do
    should 'skip non-matching w no nesting on same line' do
      b1 = lambda do |a| @x1 end; b2 = lambda do |b| @x2 end
      @thing.class.send(:define_method, :m1, &b2)
      @thing.method(:m1).should.be having_source(%(
        def m1(b)
          @x2
        end
      ))
    end

    should 'skip non-matching w single level nesting on same line' do
      b2 = (lambda do |a| lambda do |b| @x2 end end).call(1)
      @thing.class.send(:define_method, :m2, &b2)
      @thing.method(:m2).should.be having_source(%(
        def m2(b)
          @x2
        end
      ))
    end

    should 'skip non-matching w multi level nesting on same line' do
      b2 = (lambda do |a| lambda do |b| b2 = lambda do |c| @x3 end end end).call(1).call(1)
      @thing.class.send(:define_method, :m3, &b2)
      @thing.method(:m3).should.be having_source(%(
        def m3(c)
          @x3
        end
      ))
    end
  end

  describe 'w braced block' do
    should 'skip non-matching w no nesting on same line' do
      b1 = lambda {|a| @x1 }; b2 = lambda {|b| @x2 }
      @thing.class.send(:define_method, :m1, &b2)
      @thing.method(:m1).should.be having_source(%(
        def m1(b)
          @x2
        end
      ))
    end

    should 'skip non-matching w single level nesting on same line' do
      b2 = (lambda {|a| lambda {|b| @x2 } }).call(1)
      @thing.class.send(:define_method, :m2, &b2)
      @thing.method(:m2).should.be having_source(%(
        def m2(b)
          @x2
        end
      ))
    end

    should 'skip non-matching w multi level nesting on same line' do
      b2 = (lambda {|a| lambda {|b| b2 = lambda {|c| @x3 } } }).call(1).call(1)
      @thing.class.send(:define_method, :m3, &b2)
      @thing.method(:m3).should.be having_source(%(
        def m3(c)
          @x3
        end
      ))
    end
  end

end
