# -*- coding: utf-8 -*-
require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Misc (from def..end block)" do

  should 'handle accessing #to_sexp after #to_source' do
    def m1; x; end
    (m = method(:m1)).to_source
    m.should.be having_sexp(
      s(:defn, :m1, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

  should 'handle accessing #to_source after #to_sexp' do
    def m2; x; end
    (m = method(:m2)).to_sexp
    m.should.be having_source(%(
      def m2; x; end
    ))
  end

  should "handle body with '/' char" do
    def m3; x/2; end
    method(:m3).should.be having_source(%(
      def m3; x/2; end
    ))
  end

  should "handle lexer bug in missing trailing chars after '=>' operator" do
    # This example addresses bug @ http://redmine.ruby-lang.org/issues/show/3765
    {
      __LINE__ => (def m4; x; end; method(:m4))
    }.values.last.should.be having_source(%(
      def m4; x; end
    ))
  end

  should 'raise Sourcify::CannotFindSourceLocationError when Method#source_location is nil' do
    lambda { 1.method(:to_s).to_source }.should.
      raise(Sourcify::CannotFindSourceLocationError)
  end

  unless has_parsetree?
    should "raise Sourcify::CannotParseEvalCodeError when method is created from eval" do
      lambda { eval("def m5; x; end; method(:m5)").to_source }.should.
        raise(Sourcify::CannotParseEvalCodeError)
    end
  end

  should "handle body as UTF-8 string" do
    # Addresses https://github.com/ngty/sourcify/issues/15, many thanks
    # to tomykaira's pull request
    def m6; "こんにちは"; end
    method(:m6).should.be having_sexp(
      s(:defn, :m6, s(:args), s(:scope, s(:block, s(:str, "こんにちは"))))
    )
  end

end
