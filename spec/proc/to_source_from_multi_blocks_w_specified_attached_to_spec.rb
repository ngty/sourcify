require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...}' do
  unless has_parsetree?

    err1 = Sourcify::MultipleMatchingProcsPerLineError
    err2 = Sourcify::NoMatchingProcError

    describe '>> w :attached_to as regexp' do

      should "raise Sourcify::MultipleMatchingProcsPerLineError for multiple matches" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        lambda { b2.to_source(:attached_to => /^(?:.*?\W|)lambda(?:\W)/) }.should.raise(err1)
      end

      should "raise Sourcify::NoMatchingProcError for no match" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        lambda { b2.to_source(:attached_to => /^(?:.*?\W|)proc(?:\W)/) }.should.raise(err2)
      end

      should "handle for single match" do
        b1 = lambda {|a| @x1 }; b2 = proc { @x2 }; b3 = lambda { @x3 }
        b2.should.be having_source('proc { @x2 }', :attached_to => /^(?:.*?\W|)proc(?:\W)/)
      end

    end

    describe '>> w :attached_to as string' do

      should "raise Sourcify::MultipleMatchingProcsPerLineError for multiple matches" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        lambda { b2.to_source(:attached_to => 'lambda') }.should.raise(err1)
      end

      should "raise Sourcify::NoMatchingProcError for no match" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        lambda { b2.to_source(:attached_to => 'proc') }.should.raise(err2)
      end

      should "handle for single match" do
        b1 = lambda {|a| @x1 }; b2 = proc { @x2 }; b3 = lambda { @x3 }
        b2.should.be having_source('proc { @x2 }', :attached_to => 'proc')
      end

    end

    describe '>> w :attached_to as symbol' do

      should "raise Sourcify::MultipleMatchingProcsPerLineError for multiple matches" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        lambda { b2.to_source(:attached_to => :lambda) }.should.raise(err1)
      end

      should "raise Sourcify::NoMatchingProcError for no match" do
        b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
        lambda { b2.to_source(:attached_to => :proc) }.should.raise(err2)
      end

      should "handle for single match" do
        b1 = lambda {|a| @x1 }; b2 = proc { @x2 }; b3 = lambda { @x3 }
        b2.should.be having_source('proc { @x2 }', :attached_to => :proc)
      end

    end

    describe '>> w false start as a result of preceding hash' do

      option = {:attached_to => :watever}
      aa = :aa

      should 'handle for do ... end block' do
        x = watever({aa => 1, :bb => 3}) do :blah end
        x.should.be having_source('proc { :blah }', option)
      end

      should 'handle for { ... } block' do
        x = watever({aa => 1, :bb => 3}) { :blah }
        x.should.be having_source('proc { :blah }', option)
      end

    end

  end
end
