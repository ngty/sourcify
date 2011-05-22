require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Method's raw scanner > double quote strings (wo interpolation)" do
    extend Sourcify::Method::Parser::RawScanner::Spec::GenericSupport
    behaves_like "Double quote strings (wo interpolation)"
  end
end
