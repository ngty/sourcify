require File.expand_path('../spec_helper', __FILE__)

def puke(*args, &block)
  block
end

describe Sourcify::Proc::Extractor do
  describe '.process (wrt src)' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).src
    end

    example(%%
    ## wrt attache, having explicit recipient for method
    ##
    #" proc do
    #"         :thing
    #"       end
    %,(
      b = Proc.new do
        :thing
      end
    ))

    example(%%
    ## wrt attache, having implicit recipient for method
    ##
    #" proc do
    #"         :thing
    #"       end
    %,(
      b = proc do
        :thing
      end
    ))

    example(%%
    ## wrt block args, having no arg
    ##
    #" proc do
    #"         :thing
    #"       end
    %,(
      b = proc do
        :thing
      end
    ))

    example(%%
    ## wrt block args, having 1 arg
    ##
    #" proc do |x|
    #"         :thing
    #"       end
    %,(
      b = proc do |x|
        :thing
      end
    ))

    example(%%
    ## wrt block args, having multiple args
    ##
    #" proc do |x, y, z|
    #"         :thing
    #"       end
    %,(
      b = proc do |x, y, z|
        :thing
      end
    ))

    example(%%
    ## wrt block args, having only splat args
    ##
    #" proc do |*x|
    #"         :thing
    #"       end
    %,(
      b = proc do |*x|
        :thing
      end
    ))

    example(%%
    ## wrt block args, having multiple & splat args
    ##
    #" proc do |x, y, *z|
    #"         :thing
    #"       end
    %,(
      b = proc do |x, y, *z|
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
      b = proc do
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
      b = proc {
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
      b = proc do |x| proc {|y| :this }
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
      b = proc { |x| proc do |y| :this end
        :that
      }
    ))

    example(%%
    ## wrt multiple matches, having non-unique parameters (1)
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = proc do |x| proc {|x| :this }
        :that
      end
    ))

    example(%%
    ## wrt multiple matches, having non-unique parameters (2)
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = proc { |x| proc do |x| :this end
        :that
      }
    ))

    example(%%
    ## wrt positioning, attache & block on the same line
    ##
    #" proc do
    #"         :thing
    #"       end
    %,(
      b = puke do
        :thing
      end
    ))

    example(%%
    ## wrt positioning, attache & block on the different lines (1)
    ##
    #" proc do
    #"           :thing
    #"         end
    %,(
      b = puke \
        do
          :thing
        end
    ))

    example(%%
    ## wrt positioning, attache & block on the different lines (2)
    ##
    #" proc do
    #"           :thing
    #"         end
    %,(
      b = puke(
        :arg
      ) do
          :thing
        end
    ))
  end
end
