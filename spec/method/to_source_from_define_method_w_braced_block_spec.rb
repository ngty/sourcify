require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source from #define_method (w braced block)" do

  before do
    @thing = Object.new
  end

  describe 'w block declared elsewhere' do

    should 'wo arg' do
      blk = lambda { x = 1 }
      @thing.class.send(:define_method, :m1, &blk)
      @thing.method(:m1).should.be having_source(%(
        def m1
          x = 1
        end
      ))
    end

    should 'w one required arg' do
      blk = lambda {|a| x = 1 }
      @thing.class.send(:define_method, :m2, &blk)
      @thing.method(:m2).should.be having_source(%(
        def m2(a)
          x = 1
        end
      ))
    end

    should 'w one optional arg' do
      blk = lambda {|a=1| x = 1 }
      @thing.class.send(:define_method, :m3, &blk)
      @thing.method(:m3).should.be having_source(%(
        def m3(a = 1)
          x = 1
        end
      ))
    end

    should 'w one required group arg' do
      blk = lambda {|(a,b)| x = 1 }
      @thing.class.send(:define_method, :m4, &blk)
      @thing.method(:m4).should.be having_source(%(
        def m4((a,b))
          x = 1
        end
      ))
    end

    should 'w multiple required args' do
      blk = lambda {|a, b, c| x = 1 }
      @thing.class.send(:define_method, :m5, &blk)
      @thing.method(:m5).should.be having_source(%(
        def m5(a, b, c)
          x = 1
        end
      ))
    end

    should 'w multiple args w one optional' do
      blk = lambda {|a, b, c=1| x = 1 }
      @thing.class.send(:define_method, :m6, &blk)
      @thing.method(:m6).should.be having_source(%(
        def m6(a, b, c = 1)
          x = 1
        end
      ))
    end

    should 'w multiple args w one required group' do
      blk = lambda {|a, b, (c,d)| x = 1 }
      @thing.class.send(:define_method, :m7, &blk)
      @thing.method(:m7).should.be having_source(%(
        def m7(a, b, (c,d))
          x = 1
        end
      ))
    end

  end


  describe 'w block attached' do

    should 'wo arg' do
      @thing.class.send(:define_method, :m1) { x = 1 }
      @thing.method(:m1).should.be having_source(%(
        def m1
          x = 1
        end
      ))
    end

    should 'w one required arg' do
      @thing.class.send(:define_method, :m2) {|a| x = 1 }
      @thing.method(:m2).should.be having_source(%(
        def m2(a)
          x = 1
        end
      ))
    end

    should 'w one optional arg' do
      @thing.class.send(:define_method, :m3) {|a=1| x = 1 }
      @thing.method(:m3).should.be having_source(%(
        def m3(a = 1)
          x = 1
        end
      ))
    end

    should 'w one required group arg' do
      @thing.class.send(:define_method, :m4) {|(a,b)| x = 1 }
      @thing.method(:m4).should.be having_source(%(
        def m4((a,b))
          x = 1
        end
      ))
    end

    should 'w multiple required args' do
      @thing.class.send(:define_method, :m5) {|a, b, c| x = 1 }
      @thing.method(:m5).should.be having_source(%(
        def m5(a, b, c)
          x = 1
        end
      ))
    end

    should 'w multiple args w one optional' do
      @thing.class.send(:define_method, :m6) {|a, b, c=1| x = 1 }
      @thing.method(:m6).should.be having_source(%(
        def m6(a, b, c = 1)
          x = 1
        end
      ))
    end

    should 'w multiple args w one required group' do
      @thing.class.send(:define_method, :m7) {|a, b, (c,d)| x = 1 }
      @thing.method(:m7).should.be having_source(%(
        def m7(a, b, (c,d))
          x = 1
        end
      ))
    end

  end

end
