require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...}' do
  unless has_parsetree?

    before { @thing = Object.new }

    err1 = Sourcify::MultipleMatchingProcsPerLineError
    err2 = Sourcify::NoMatchingProcError

    describe '>> w :attached_to as regexp' do

      should "raise Sourcify::MultipleMatchingProcsPerLineError for multiple matches" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        @thing.class.send(:define_method, :m1, &b2)
        lambda { @thing.method(:m1).to_source(:attached_to => /^(?:.*?\W|)lambda(?:\W)/) }.should.raise(err1)
      end

      should "raise Sourcify::NoMatchingProcError for no match" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        @thing.class.send(:define_method, :m2, &b2)
        lambda { @thing.method(:m2).to_source(:attached_to => /^(?:.*?\W|)proc(?:\W)/) }.should.raise(err2)
      end

      should "handle for single match" do
        b1 = lambda {|a| @x1 }; b2 = proc { @x2 }; b3 = lambda { @x3 }
        @thing.class.send(:define_method, :m3, &b2)
        @thing.method(:m3).should.be having_source('def m3; @x2; end', :attached_to => /^(?:.*?\W|)proc(?:\W)/)
      end

    end

    describe '>> w :attached_to as string' do

      should "raise Sourcify::MultipleMatchingProcsPerLineError for multiple matches" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        @thing.class.send(:define_method, :m1, &b2)
        lambda { @thing.method(:m1).to_source(:attached_to => 'lambda') }.should.raise(err1)
      end

      should "raise Sourcify::NoMatchingProcError for no match" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        @thing.class.send(:define_method, :m2, &b2)
        lambda { @thing.method(:m2).to_source(:attached_to => 'proc') }.should.raise(err2)
      end

      should "handle for single match" do
        b1 = lambda {|a| @x1 }; b2 = proc { @x2 }; b3 = lambda { @x3 }
        @thing.class.send(:define_method, :m3, &b2)
        @thing.method(:m3).should.be having_source('def m3; @x2; end', :attached_to => 'proc')
      end

    end

    describe '>> w :attached_to as symbol' do

      should "raise Sourcify::MultipleMatchingProcsPerLineError for multiple matches" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        @thing.class.send(:define_method, :m1, &b2)
        lambda { @thing.method(:m1).to_source(:attached_to => :lambda) }.should.raise(err1)
      end

      should "raise Sourcify::NoMatchingProcError for no match" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        @thing.class.send(:define_method, :m2, &b2)
        lambda { @thing.method(:m2).to_source(:attached_to => :proc) }.should.raise(err2)
      end

      should "handle for single match" do
        b1 = lambda {|a| @x1 }; b2 = proc { @x2 }; b3 = lambda { @x3 }
        @thing.class.send(:define_method, :m3, &b2)
        @thing.method(:m3).should.be having_source('def m3; @x2; end', :attached_to => :proc)
      end

    end

    describe '>> w false start as a result of preceding hash' do

      option = {:attached_to => :watever}
      aa = :aa

      should 'handle for do ... end block' do
        x = watever({aa => 1, :bb => 3}) do :blah end
        @thing.class.send(:define_method, :m1, &x)
        @thing.method(:m1).should.be having_source('def m1; :blah; end', option)
      end

      should 'handle for { ... } block' do
        x = watever({aa => 1, :bb => 3}) { :blah }
        @thing.class.send(:define_method, :m2, &x)
        @thing.method(:m2).should.be having_source('def m2; :blah; end', option)
      end

    end

  end
end
