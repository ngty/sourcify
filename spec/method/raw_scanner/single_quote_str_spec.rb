require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Method's raw scanner > single quote strings (\', %q & %w)" do
    extend Sourcify::Method::Parser::RawScanner::Spec::GenericSupport
    behaves_like 'Single quote strings (\', %q & %w)'
  end
end
