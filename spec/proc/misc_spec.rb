require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Misc" do

  should 'handle accessing #to_sexp after #to_source' do
    (s_proc = lambda { :test }).to_source
    s_proc.to_sexp.should.equal(s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:lit, :test)))
  end

  should 'handle accessing #to_source after #to_sexp' do
    (s_proc = lambda { :test }).to_sexp
    s_proc.to_source.should.equal('proc { :test }')
  end

end

