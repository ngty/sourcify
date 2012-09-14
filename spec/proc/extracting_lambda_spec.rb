require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  describe 'extracting lambda' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).src
    end

    example(%%
    ## wrt args, having no arg
    ##
    #" lambda do
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
    #" lambda do |x|
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
    #" lambda do |x, y, z|
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
    #" lambda do |*x|
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
    #" lambda do |x, y, *z|
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
    #" lambda do
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
    #" lambda {
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
    #" lambda do |x| ->(y) { :this }
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
    #" lambda { |x| ->(y) do :this end
    #"         :that
    #"       }
    %,(
      b = ->(x) { ->(y) do :this end
        :that
      }
    ))

    example(%%
    ## wrt multiple matches, having unique parameters (3)
    ##
    #" lambda { |y| :that }
    %,(
      b = (->(x) do :this end; ->(y) { :that })
    ))

    example(%%
    ## wrt multiple matches, having unique parameters (4)
    ##
    #" lambda do |y| :that end
    %,(
      b = (->(x) { :this }; ->(y) do :that end)
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
    ## wrt multiple matches, having non-unique parameters (3)
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = (->(x) do :this end; ->(x) { :that })
    ))

    example(%%
    ## wrt multiple matches, having non-unique parameters (4)
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = (->(x) { :this }; ->(x) do :that end)
    ))

    example(%%
    ## wrt positioning, operator & block on the same line
    ##
    #" lambda do
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
    #" lambda do
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
    #" lambda do |
    #"           x\\
    #"         |
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
