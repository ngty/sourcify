# encoding: UTF-8
require File.expand_path('../spec_helper', __FILE__)

def m(*args, &block)
  block
end

describe Sourcify::Proc do
  describe 'with misc' do
    extend Sourcify::SpecHelper

    def process(block)
      block.to_source
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
    ## wrt heredoc (4)
    ##
    #" proc do
    #"   s = <<EOL
    #"           thing
    #" EOL
    #" end
    %,(
      b = proc do
        s = <<EOL
          thing
EOL
      end
    ))

    example(%%
    ## wrt elaborated indentation
    ##
    #" proc do
    #"   x = {
    #"     :a => {
    #"       :b => 1,
    #"       :c => 2
    #"     },
    #"     :d => 3
    #"   }
    #" end
    %,(
      b = proc do
        x = {
          :a => {
            :b => 1,
            :c => 2
          },
          :d => 3
        }
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
    ## wrt proc created by eval
    ##
    #! Sourcify::CannotHandleEvalCodeError
    %,(
      eval(%%b = proc { :thing }%)
    ))

  end
end
