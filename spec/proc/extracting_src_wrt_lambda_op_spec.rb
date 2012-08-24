require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  describe '.process (wrt src & lambda operator)' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).src
    end

    example(%%
    ## wrt args, having no arg
    ##
    #" proc do
    #"         :thing
    #"       end
    %,(
      b = -> do
        :thing
      end
    ))

    example(%%
    ## wrt args, having 1 arg
    ##
    #" proc do |x|
    #"         :thing
    #"       end
    %,(
      b = ->(x) do
        :thing
      end
    ))

    example(%%
    ## wrt args, having multiple args
    ##
    #" proc do |x, y, z|
    #"         :thing
    #"       end
    %,(
      b = ->(x, y, z) do
        :thing
      end
    ))

    example(%%
    ## wrt args, having only splat args
    ##
    #" proc do |*x|
    #"         :thing
    #"       end
    %,(
      b = ->(*x) do
        :thing
      end
    ))

    example(%%
    ## wrt args, having multiple & splat args
    ##
    #" proc do |x, y, *z|
    #"         :thing
    #"       end
    %,(
      b = ->(x, y, *z) do
        :thing
      end
    ))

    example(%%
    ## wrt block type, as do-block
    ##
    #" proc do
    #"         :thing
    #"       end
    %,(
      b = -> do
        :thing
      end
    ))

    example(%%
    ## wrt block type, as brace-block
    ##
    #" proc {
    #"         :thing
    #"       }
    %,(
      b = -> {
        :thing
      }
    ))

    example(%%
    ## wrt multiple matches, having unique parameters (1)
    ##
    #" proc do |x| proc {|y| :this }
    #"         :that
    #"       end
    %,(
      b = ->(x) do ->(y) { :this }
        :that
      end
    ))

    example(%%
    ## wrt multiple matches, having unique parameters (2)
    ##
    #" proc { |x| proc do |y| :this end
    #"         :that
    #"       }
    %,(
      b = ->(x) { ->(y) do :this end
        :that
      }
    ))

    example(%%
    ## wrt multiple matches, having non-unique parameters (1)
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = ->(x) do ->(x) { :this }
        :that
      end
    ))

    example(%%
    ## wrt multiple matches, having non-unique parameters (2)
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = ->(x) { ->(x) do :this end
        :that
      }
    ))

    example(%%
    ## wrt positioning, operator & block on the same line
    ##
    #" proc do
    #"         :thing
    #"       end
    %,(
      b = -> do
        :thing
      end
    ))

    example(%%
    ## wrt positioning, operator & block on different lines (1)
    ##
    #" proc do
    #"           :thing
    #"         end
    %,(
      b = -> \
        do
          :thing
        end
    ))

    example(%%
    ## wrt positioning, operator & block on different lines (2)
    ##
    #" proc do |x|
    #"           :thing
    #"         end
    %,(
      b = ->(
          x
        ) do
          :thing
        end
    ))

  end
end
