# encoding: UTF-8
require File.expand_path('../spec_helper', __FILE__)

def m(*args, &block)
  block
end

describe Sourcify::Proc::Extractor do
  describe 'extracting misc' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).src
    end

    example(%%
    ## wrt heredoc (1)
    ##
    #" proc do
    #"   s = <<-EOL
    #"           thing
    #"   EOL
    #" end
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
    #" proc do
    #"   s = <<-EOL.strip
    #"           thing
    #"   EOL
    #" end
    %,(
      b = proc do
        s = <<-EOL.strip
          thing
        EOL
      end
    ))

    example(%%
    ## wrt heredoc (3)
    ##
    #" proc do
    #"   s = <<-'EOL'
    #"           thing
    #"   EOL
    #" end
    %,(
      b = proc do
        s = <<-'EOL'
          thing
        EOL
      end
    ))

    example(%%
    ## wrt comments
    ##
    #" proc do
    #"   # shouldnt remove me !!
    #"   :thing
    #" end
    %,(
      b = proc do
        # shouldnt remove me !!
        :thing
      end
    ))

    example(%%
    ## wrt encoding, having utf8 string
    ##
    #" proc do
    #"   "こんにちは"
    #" end
    %,(
      b = proc do
        "こんにちは"
      end
    ))

    example(%%
    ## wrt encoding, having unicode regexp
    ##
    #" proc do
    #"   /\\\p{Lu}/
    #" end
    %,(
      b = proc do
        /\p{Lu}/
      end
    ))

    example(%%
    ## wrt preceding hash, having no items (1)
    ##
    #" proc do
    #"   :thing
    #" end
    %,(
      b = m({}) do
        :thing
      end
    ))

    example(%%
    ## wrt preceding hash, having no items (2)
    ##
    #" proc { :thing }
    %,(
      b = m({}) { :thing }
    ))

    example(%%
    ## wrt preceding hash, having no items (3)
    ##
    #" proc { }
    %,(
      b = m({}) { }
    ))

    example(%%
    ## wrt preceding hash, having items (1)
    ##
    #" proc do
    #"   :thing
    #" end
    %,(
      b = m({:a => 1, :b => 2}) do
        :thing
      end
    ))

    example(%%
    ## wrt preceding hash, having items (2)
    ##
    #" proc { :thing }
    %,(
      b = m({:a => 1, :b => 2}) { :thing }
    ))

  end
end
