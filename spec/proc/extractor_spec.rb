require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  extend Sourcify::Proc::SpecHelper

  describe '.extract_source' do
    def process(block)
      Sourcify::Proc::Extractor.extract_source(block)
    end

    run_examples 'extractor/extract_source'
  end

  describe '.extract_raw_source' do
    def process(block)
      Sourcify::Proc::Extractor.extract_raw_source(block)
    end

    run_examples 'extractor/extract_raw_source'
  end

end
