require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > heredoc (wo indent)" do
    extend Sourcify::Proc::Parser::RawScanner::Spec::GenericSupport
    behaves_like "Heredoc (wo indent)"
  end
end
