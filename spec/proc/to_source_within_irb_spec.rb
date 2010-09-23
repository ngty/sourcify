require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source within IRB" do

  should 'handle basic' do
    normalize_code(irb_exec(%Q(
      x = lambda { 1+2 }
      y = lambda { 2+3 }
      z = lambda { 3+4 }
      y.to_source
    ))[-1]).should.equal normalize_code('proc { 2+3 }')
  end

  should 'handle magic variable __FILE__' do
    normalize_code(irb_exec(%Q(
      lambda { __FILE__ }.to_source
    ))[-1]).should.equal normalize_code('proc { "(irb)" }')
  end

  should 'handle magic variable __LINE__' do
    normalize_code(irb_exec(%Q(
      lambda { __LINE__ }.to_source
    ))[-1]).should.equal normalize_code('proc { 2 }')
  end

end
