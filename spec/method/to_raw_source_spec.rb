require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_raw_source" do

  should 'retain comments' do
    def m1
      a = 1
      # i should stay !!
    end
    method(:m1).should.be having_raw_source(%(
    def m1
      a = 1
      # i should stay !!
    end
    ))
  end

  should 'retain last nil statement' do
    def m2
      a = 1
      nil
    end
    method(:m2).should.be having_raw_source(%(
    def m2
      a = 1
      nil
    end
    ))
  end

end
