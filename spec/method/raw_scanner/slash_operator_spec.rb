require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Method's raw scanner > slash operator" do
    extend Sourcify::Method::Parser::RawScanner::Spec::GenericSupport
    behaves_like 'Slash operator'
  end
end
