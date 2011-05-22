require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > single quote strings (\', %q & %w)" do
    extend Sourcify::Proc::Parser::RawScanner::Spec::GenericSupport
    behaves_like 'Single quote strings (\', %q & %w)'
  end
end
