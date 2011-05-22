require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Method's raw scanner > double quote strings (w interpolation)" do
    extend Sourcify::Method::Parser::RawScanner::Spec::GenericSupport
    behaves_like "Double quote strings (w interpolation)"
  end
end
