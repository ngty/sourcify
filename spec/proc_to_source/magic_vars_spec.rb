require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source (magic vars)" do

  should 'handle __FILE__' do
    (
      lambda { __FILE__ }
    ).should.be having_code(%|proc { "#{__FILE__}" }|)
  end

  should 'handle __LINE__' do
    (
      lambda { __LINE__ }
    ).should.be having_code(%|proc { #{__LINE__.pred} }|)
  end

end
