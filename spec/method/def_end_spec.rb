require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Method do
  describe 'with def...end' do
    extend Sourcify::SpecHelper

    def defm(name, &block)
      thing = (@klass ||= Class.new{}).new
      thing.instance_eval(&block)
      thing.method(name)
    end

    def process(method)
      method.to_source
    end

    example(%%
    ## wrt args, having no arg
    ##
    #" def m
    #"   :thing
    #" end
    %,(
      defm :m do
        def m
          :thing
        end
      end
    ))

    example(%%
    ## wrt args, having 1 arg
    ##
    #" def m(x)
    #"   :thing
    #" end
    %,(
      defm :m do
        def m(x)
          :thing
        end
      end
    ))

    example(%%
    ## wrt args, having multiple args
    ##
    #" def m(x, y, z)
    #"   :thing
    #" end
    %,(
      defm :m do
        def m(x, y, z)
          :thing
        end
      end
    ))

    example(%%
    ## wrt args, having only splat args
    ##
    #" def m(*x)
    #"   :thing
    #" end
    %,(
      defm :m do
        def m(*x)
          :thing
        end
      end
    ))

    example(%%
    ## wrt args, having multiple & splat args
    ##
    #" def m(x, y, *z)
    #"   :thing
    #" end
    %,(
      defm :m do
        def m(x, y, *z)
          :thing
        end
      end
    ))

    example(%%
    ## wrt multiple matches, having unique parameters (1)
    ##
    #" proc do |x| proc {|y| :this }
    #"   :that
    #" end
    %,(
      b = proc do |x| proc {|y| :this }
        :that
      end
    ))

  end
end
