require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Source do

  before do
    @proc = proc { :nil } # [6,12] .. [6,25]]
    @line = __LINE__.pred
    @source = Sourcify::Proc::Source.new(__FILE__, @line)
  end


  describe '#metadata' do
    before { @metadata = @source.metadata }

    it 'must describe file' do
      @metadata.file.must_equal(__FILE__)
    end

    it 'must describe sexp' do
      @metadata.sexp.must_equal(
        [:method_add_block,
         [:method_add_arg, [:fcall, [:@ident, "proc", [@line, 12]]], [:args_new]],
         [:brace_block,
          nil,
          [:stmts_add,
           [:stmts_new],
           [:symbol_literal, [:symbol, [:@kw, "nil", [@line, 20]]]]]]]
      )
    end

    it 'must describe start position' do
      @metadata.from_pos.must_equal([@line,12])
    end

    it 'must describe end position' do
      @metadata.till_pos.must_equal([@line,25])
    end
  end


  describe '#raw' do
    before { @raw_source = @source.raw }

    it 'must return an instance of Sourcify::Proc::RawSource' do
      @raw_source.must_be_instance_of(Sourcify::Proc::RawSource)
    end

    it 'must have source & raw source sharing the same metadata' do
      @raw_source.metadata.must_be_same_as(@source.metadata)
    end
  end 

end
