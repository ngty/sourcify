require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > slash operator" do
    behaves_like 'Slash operator'
  end
end
