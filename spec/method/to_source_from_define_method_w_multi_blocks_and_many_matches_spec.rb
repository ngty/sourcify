require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source from #define_method w multi blocks and many matches' do

  unless has_parsetree?

    before do
      @thing = Object.new
    end

    error = Sourcify::MultipleMatchingProcsPerLineError

    should "raise #{error} w no nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
      @thing.class.send(:define_method, :m1, &b2)
      lambda { @thing.method(:m1).to_source }.should.raise(error)
    end

    should "raise #{error} w single level nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { lambda { @x } }
      @thing.class.send(:define_method, :m2, &b2)
      lambda { @thing.method(:m2).to_source }.should.raise(error)
    end

    should "raise #{error} w multi level nesting on same line" do
      b2 = (lambda {|a| lambda { lambda { @x } } }).call(1)
      @thing.class.send(:define_method, :m3, &b2)
      lambda { @thing.method(:m3).to_source }.should.raise(error)
    end

  end

end
