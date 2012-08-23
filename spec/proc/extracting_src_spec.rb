require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  describe '.process (wrt src)' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).src
    end

    example(%%
    ## wrt attache, having declared recipient for method
    ##
    #"           Proc.new do
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
    #"           proc do
    #"         :thing
    #"       end
    %,(
      b = proc do
        :thing
      end
    ))

    example(%%
    ## wrt attache, having explicit recipient for method
    ##
    #"           subject.new do
    #"         :thing
    #"       end
    %,(
      subject = Proc
      b = subject.new do
        :thing
      end
    ))

    example(%%
    ## wrt block args, having no arg
    ##
    #"           proc do
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
    #"           proc do |x|
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
    #"           proc do |x, y, z|
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
    #"           proc do |*x|
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
    #"           proc do |x, y, *z|
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
    #"           proc do
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
    #"           proc {
    #"         :thing
    #"       }
    %,(
      b = proc {
        :thing
      }
    ))

    example(%%
    ## wrt multiple matches, having unique parameters
    ##
    #"           proc do |x| proc {|y| :this }
    #"         :that
    #"       end
    %,(
      b = proc do |x| proc {|y| :this }
        :that
      end
    ))

    example(%%
    ## wrt multiple matches, having non-unique parameters
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = proc do |x| proc {|x| :this }
        :that
      end
    ))

  end
end
