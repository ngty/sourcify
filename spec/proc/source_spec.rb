require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Source do

  describe '#metadata' do
    before do
      proc { :nil } # [7,6] .. [7,19]
      @metadata = Sourcify::Proc::Source.new(__FILE__, __LINE__.pred).metadata
    end

    it 'must describe file' do
      @metadata.file.must_equal(__FILE__)
    end

    it 'must describe sexp' do
      @metadata.sexp.must_equal(
        [:method_add_block,
         [:method_add_arg, [:fcall, [:@ident, "proc", [7, 6]]], [:args_new]],
         [:brace_block,
          nil,
          [:stmts_add,
           [:stmts_new],
           [:symbol_literal, [:symbol, [:@kw, "nil", [7, 14]]]]]]]
      )
    end

    it 'must describe start position' do
      @metadata.from_pos.must_equal([7,6])
    end

    it 'must describe end position' do
      @metadata.till_pos.must_equal([7,19])
    end
  end

end
