require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::SexpUtil do
  extend Sourcify::Proc::SpecHelper

  describe '#locate' do
    def process(block)
      file, line = block.source_location
      Sourcify::Proc::SexpUtil.new(File.read(file)).locate(:line => line)
    end

    run_examples 'sexp_util/locate_wrt_attache'
    run_examples 'sexp_util/locate_wrt_block_type'
    run_examples 'sexp_util/locate_wrt_block_arg'
  end

  describe '#extract' do
    def process(block)
      file, line = block.source_location
      Sourcify::Proc::SexpUtil.new(File.read(file)).extract(:line => line)
    end

    run_examples 'sexp_util/extract_wrt_attache'
    run_examples 'sexp_util/extract_wrt_block_type'
    run_examples 'sexp_util/extract_wrt_block_arg'
  end
end
