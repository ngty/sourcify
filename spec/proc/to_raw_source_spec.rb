require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_raw_source" do

  should 'retain comments' do
    (
      lambda do
        a = 1
        # i should stay !!
      end
    ).should.be having_raw_source(%(
      proc do
        a = 1
        # i should stay !!
      end
    ))
  end

  should 'retain last nil statement' do
    (
      lambda do
        a = 1
        nil
      end
    ).should.be having_raw_source(%(
      proc do
        a = 1
        nil
      end
    ))
  end

end
