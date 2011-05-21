require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > block comment (=begin ... =end)" do
    behaves_like "Block comment (=begin ... =end)"
  end
end
