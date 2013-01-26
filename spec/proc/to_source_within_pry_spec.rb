require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source within PRY" do

  class << self

    def pry_eval(string)
      pry_exec(string)[-1]
    end

    def equal_to(expected)
      lambda {|found| normalize_code(found) == normalize_code(expected) }
    end

  end

  should 'handle basic' do
    pry_eval(%Q(
      x = lambda { 1+2 }
      y = lambda { 2+3 }
      z = lambda { 3+4 }
      y.to_source
    )).should.be equal_to('proc { 2+3 }')
  end

  should 'handle magic variable __FILE__' do
    pry_eval(%Q(
      # NOTE: this line is needed to fix one-liner issue w pry
      lambda { __FILE__ }.to_source
    )).should.be equal_to('proc { "(pry)" }')
  end

  should 'handle magic variable __LINE__' do
    pry_eval(%Q(
      # NOTE: this line is needed to fix one-liner issue w pry
      lambda { __LINE__ }.to_source
    )).should.be equal_to('proc { 2 }')
  end


  # NOTE: The rest address issue#22, kudos goes to @scooter-dangle
  # for providing such detailed examples :)
  #
  #should 'handle a single upward scroll' do
  #  pry_eval(%Q(
  #    a = lambda { |proc| proc.to_source }
  #    a[(lambda { 0 })]
  #    a[(lambda { 1 })]
  #    OA
  #  )).should.be equal_to('proc { 1 }')
  #end
  #
  #should 'handle a double upward scroll' do
  #  pry_eval(%Q(
  #    a = lambda { |proc| proc.to_source }
  #    a[(lambda { 0 })]
  #    a[(lambda { 1 })]
  #    OAOA
  #  )).should.be equal_to('proc { 0 }')
  #end

end
