require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc do
  describe 'stripping proc' do
    extend Sourcify::SpecHelper

    def process(block)
      block.to_source.strip
    end

    example(%%
    ## wrt block args, having no arg
    ##
    #" :thing
    %,(
      b = proc do
        :thing
      end
    ))

    example(%%
    ## wrt block args, having 1 arg
    ##
    #" :thing
    %,(
      b = proc do |x|
        :thing
      end
    ))

    example(%%
    ## wrt block args, having multiple args
    ##
    #" :thing
    %,(
      b = proc do |x, y, z|
        :thing
      end
    ))

    example(%%
    ## wrt heredoc (1)
    ##
    #" s = <<-EOL
    #"           thing
    #"         EOL
    %,(
      b = proc do
        s = <<-EOL
          thing
        EOL
      end
    ))

    example(%%
    ## wrt heredoc (2)
    ##
    #" s = <<EOL
    #"           thing
    #" EOL
    %,(
      b = proc do
        s = <<EOL
          thing
EOL
      end
    ))

    example(%%
    ## wrt one-liner body
    ##
    #" :thing
    %,(
      b = proc { :thing }
    ))

    example(%%
    ## wrt multi-line body
    ##
    #" proc do
    #"   :thing
    #" end
    %,(
      b = proc do
        proc do
          :thing
        end
      end
    ))

  end
end
