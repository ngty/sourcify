require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > double quote strings (w interpolation)" do
    extend Sourcify::Proc::Parser::RawScanner::Spec::GenericSupport
    behaves_like "Double quote strings (w interpolation)"
  end
end
