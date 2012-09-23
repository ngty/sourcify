require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  describe 'extracting within pry' do
    extend Sourcify::SpecHelper

    def process(string)
      pry_exec \
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
    %.strip)

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
    %.strip)

  end
end
