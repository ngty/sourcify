require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > per line comment (# ...)" do
    behaves_like "Per line comment (# ...)"
  end
end
