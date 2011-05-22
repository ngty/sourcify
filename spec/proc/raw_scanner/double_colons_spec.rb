require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > double colons" do
    extend Sourcify::Proc::Parser::RawScanner::Spec::GenericSupport
    behaves_like "Double colons"
  end
end
