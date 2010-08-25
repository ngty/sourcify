require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source (variables)" do

  should 'handle non var' do
    lambda { x }.should.be having_source(%|proc { x }|)
  end

  should 'handle local var' do
    x = 'lx'
    lambda { x }.should.be having_source(%|proc { x }|)
  end

  should 'handle instance var' do
    @x = 'ix'
    lambda { @x }.should.be having_source(%|proc { @x }|)
  end

  should 'handle class var' do
    @@x = 'cx'
    lambda { @@x }.should.be having_source(%|proc { @@x }|)
  end

  should 'handle global var' do
    $x = 'gx'
    lambda { $x }.should.be having_source(%|proc { $x }|)
  end

  should 'handle magic var __FILE__' do
    lambda { __FILE__ }.should.be having_source(%|proc { "#{__FILE__}" }|)
  end

  should 'handle magic var __LINE__' do
    lambda { __LINE__ }.should.be having_source(%|proc { #{__LINE__} }|)
  end

end
