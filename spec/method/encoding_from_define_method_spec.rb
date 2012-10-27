# -*- coding: utf-8 -*-
require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Encoding (from define_method)" do
  next unless Sourcify::IS_19x

  before { @thing = Object.new }

  should "handle body as UTF-8 string" do
    b = lambda { "こんにちは" }
    @thing.class.send(:define_method, :m1, &b)
    @thing.method(:m1).should.be having_sexp(
      s(:defn, :m1, s(:args), s(:scope, s(:block, s(:str, "こんにちは"))))
    )
  end

  should "handle body with unicode regexp" do
    # NOTE: This specifically addresses https://github.com/ngty/sourcify/issues/15
    b = lambda { /\p{Lu}/ }
    @thing.class.send(:define_method, :m2, &b)
    @thing.method(:m2).should.be having_sexp(
      s(:defn, :m2, s(:args), s(:scope, s(:block, s(:lit, /\p{Lu}/))))
    )
  end

  should "handle body with UTF-8 heredoc" do
    b = lambda do
      <<-EOL
        こんにちは
      EOL
    end
    @thing.class.send(:define_method, :m3, &b)
    @thing.method(:m3).should.be having_sexp(
      s(:defn, :m3, s(:args), s(:scope, s(:block, s(:str, "        こんにちは\n"))))
    )
  end
end
