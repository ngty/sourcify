require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'Proc#to_sexp from multi blocks w many matches' do

  if RUBY_VERSION.include?('1.9.')
    require File.join(File.dirname(__FILE__), '19x_extras')
    behaves_like 'Proc#to_sexp from multi blocks w many matches spec (1.9.*)'
  else
    require File.join(File.dirname(__FILE__), '18x_extras')
    behaves_like 'Proc#to_sexp from multi blocks w many matches spec (1.8.*)'
  end

end
