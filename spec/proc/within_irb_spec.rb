require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc do
  describe 'within irb' do
    extend Sourcify::SpecHelper

    def process(string)
      irb_exec \
        <<-RUBY
          block = #{string}
          Sourcify::Proc::Extractor.process(block).to_s
        RUBY
    end

    example(%%
    ## wrt proc
    ##
    #" proc do
    #"   :thing
    #" end
    %,%%
      proc do
        :thing
      end
    %)

    example(%%
    ## wrt lambda
    ##
    #" lambda do
    #"   :thing
    #" end
    %,%%
      -> do
        :thing
      end
    %)

  end
end
