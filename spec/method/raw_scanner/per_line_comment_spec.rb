require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Method's raw scanner > per line comment (# ...)" do
    extend Sourcify::Method::Parser::RawScanner::Spec::GenericSupport
    behaves_like "Per line comment (# ...)"
  end
end
