require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source from def ... end block (w nested do ... end block)" do

  should 'handle simple' do
    def m1
      lambda do @x1 = 1 end
    end
    method(:m1).should.be having_source(%(
      def m1
        lambda { @x1 = 1 }
      end
    ))
  end

  should 'handle nested' do
    def m2
      lambda do
        lambda do @x1 = 1 end
      end
    end
    method(:m2).should.be having_source(%(
      def m2
        lambda do
          lambda { @x1 = 1 }
        end
      end
    ))
  end

end
