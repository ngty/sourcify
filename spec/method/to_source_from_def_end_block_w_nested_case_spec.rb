require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source from def ... end block (w nested case)" do

  should 'handle simple' do
    def m1
      case @x1 when true then false end
    end
    method(:m1).should.be having_source(%(
      def m1
        case @x1 when true then false end
      end
    ))
  end

  should 'handle nested' do
    def m2
      case @x1
      when true
        case @x2 when false then true end
      end
    end
    method(:m2).should.be having_source(%(
      def m2
        case @x1
        when true
          case @x2 when false then true end
        end
      end
    ))
  end

end
