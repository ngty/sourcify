require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::SexpUtil do
  extend Sourcify::Proc::SpecHelper

  describe '#locate' do
    def process(block)
      file, line = block.source_location
      Sourcify::Proc::SexpUtil.new(File.read(file)).locate(:line => line)
    end

    run_examples 'sexp_util/class_locate'
    run_examples 'sexp_util/instance_locate'
    run_examples 'sexp_util/self_locate'
  end

  describe '#extract' do
    def process(block)
      file, line = block.source_location
      Sourcify::Proc::SexpUtil.new(File.read(file)).extract(:line => line)
    end

    run_examples 'sexp_util/class_extract'
    run_examples 'sexp_util/instance_extract'
    run_examples 'sexp_util/self_extract'
  end
end
