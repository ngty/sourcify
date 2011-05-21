require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > double quote strings (wo interpolation)" do
    behaves_like "Double quote strings (wo interpolation)"
  end
end
