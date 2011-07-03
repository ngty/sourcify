require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source (from def...end block)' do
  describe 'w multi blocks and many matches' do

    if has_parsetree?
      # TODO: Should we support this ??
    else

      error = Sourcify::MultipleMatchingMethodsPerLineError

      should "raise #{error} w no nesting on same line" do
        def m1; @x1; end; def m1; @x2; end
        lambda { method(:m1).to_source }.should.raise(error)
      end

      should "raise #{error} w single level nesting on same line" do
        def m2; class << self; def m2; @x1; end; end; end
        lambda { method(:m2).to_source }.should.raise(error)
      end

      should "raise #{error} w multi level nesting on same line" do
        def m3; class << self; def m3; class << self; def m3; @x1; end; end; end; end; end
        lambda { method(:m3).to_source }.should.raise(error)
      end

    end

  end
end
