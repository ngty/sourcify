require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > single quote strings (\', %q & %w)" do
    behaves_like 'Single quote strings (\', %q & %w)'
  end
end
