# -*- coding: utf-8 -*-
require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Encoding (from def..end block)" do
  next unless Sourcify::IS_19x

  should "handle body as UTF-8 string" do
    def m1; "こんにちは"; end
    method(:m1).should.be having_sexp(
      s(:defn, :m1, s(:args), s(:scope, s(:block, s(:str, "こんにちは"))))
    )
  end

  should "handle body with unicode regexp" do
    # NOTE: This specifically addresses https://github.com/ngty/sourcify/issues/15
    def m2; /\p{Lu}/ ; end
    method(:m2).should.be having_sexp(
      s(:defn, :m2, s(:args), s(:scope, s(:block, s(:lit, /\p{Lu}/))))
    )
  end

  should "handle body with UTF-8 heredoc" do
    def m3
      <<-EOL
        こんにちは
      EOL
    end
    method(:m3).should.be having_sexp(
      s(:defn, :m3, s(:args), s(:scope, s(:block, s(:str, "        こんにちは\n"))))
    )
  end

end
