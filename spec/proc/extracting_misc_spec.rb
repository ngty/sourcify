# encoding: UTF-8
require File.expand_path('../spec_helper', __FILE__)

def puke(*args, &block)
  block
end

describe Sourcify::Proc::Extractor do
  describe 'extracting misc' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).src
    end

    example(%%
    ## wrt comments
    ##
    #" proc {
    #"         # shouldnt remove me !!
    #"         :thing
    #"       }
    %,(
      b = proc {
        # shouldnt remove me !!
        :thing
      }
    ))

    example(%%
    ## wrt encoding, having utf8 string
    ##
    #" proc {
    #"         "こんにちは"
    #"       }
    %,(
      b = proc {
        "こんにちは"
      }
    ))

    example(%%
    ## wrt encoding, having unicode regexp
    ##
    #" proc {
    #"         /\p{Lu}/
    #"       }
    %,(
      b = proc {
        /\p{Lu}/
      }
    ))

  end
end
