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
    #"   x = {
    #"     a: 1,
    #"     b: 2
    #"   }
    #" end
    %,%%
      proc do
        x = {
          a: 1,
          b: 2
        }
      end
    %.strip)

    example(%%
    ## wrt lambda
    ##
    #" lambda do
    #"   x = {
    #"     a: 1,
    #"     b: 2
    #"   }
    #" end
    %,%%
      -> do
        x = {
          a: 1,
          b: 2
        }
      end
    %.strip)

  end
end
