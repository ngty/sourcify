require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source within IRB" do

  class << self

    def irb_eval(string)
      irb_exec(string)[-1]
    end

    def equal_to(expected)
      lambda {|found| normalize_code(found) == normalize_code(expected) }
    end

  end

  should 'handle basic' do
    irb_eval(%Q(
      x = lambda { 1+2 }
      y = lambda { 2+3 }
      z = lambda { 3+4 }
      y.to_source
    )).should.be equal_to('proc { 2+3 }')
  end

  should 'handle magic variable __FILE__' do
    irb_eval(%Q(
      lambda { __FILE__ }.to_source
    )).should.be equal_to('proc { "(irb)" }')
  end

  should 'handle magic variable __LINE__' do
    irb_eval(%Q(
      lambda { __LINE__ }.to_source
    )).should.be equal_to('proc { 2 }')
  end

end
