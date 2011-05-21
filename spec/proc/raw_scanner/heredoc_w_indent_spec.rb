require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > heredoc (w indent)" do
    behaves_like "Heredoc (w indent)"
  end
end
