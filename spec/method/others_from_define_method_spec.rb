# -*- coding: utf-8 -*-
require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Misc (from define_method)" do

  before { @thing = Object.new }

  should 'handle accessing #to_sexp after #to_source' do
    blk = lambda { x }
    @thing.class.send(:define_method, :m1, &blk)
    (m = @thing.method(:m1)).to_source
    m.should.be having_sexp(
      s(:defn, :m1, s(:args), s(:scope, s(:block, s(:call, nil, :x, s(:arglist)))))
    )
  end

  should 'handle accessing #to_source after #to_sexp' do
    blk = lambda { x }
    @thing.class.send(:define_method, :m2, &blk)
    (m = @thing.method(:m2)).to_sexp
    m.should.be having_source(%(
      def m2; x; end
    ))
  end

  should "handle body with '/' char" do
    blk = lambda { x / 2 }
    @thing.class.send(:define_method, :m3, &blk)
    @thing.method(:m3).should.be having_source(%(
      def m3; x / 2; end
    ))
  end

  should "handle lexer bug in missing trailing chars after '=>' operator" do
    # This example addresses bug @ http://redmine.ruby-lang.org/issues/show/3765
    hash = {
      :x => lambda { x }
    }
    @thing.class.send(:define_method, :m4, &(hash[:x]))
    @thing.method(:m4).should.be having_source(%(
      def m4; x; end
    ))
  end

  should "handle lexer bug in missing trailing chars after '=>' operator" do
    # This example addresses bug @ http://redmine.ruby-lang.org/issues/show/3765
    hash = {
      :blk => lambda do x end
    }
    @thing.class.send(:define_method, :m5, &(hash[:blk]))
    @thing.method(:m5).should.be having_source(%(
      def m5; x; end
    ))
  end

  unless has_parsetree?
    should "raise Sourcify::CannotParseEvalCodeError when method is created from eval" do
      lambda { eval("klass = Class.new { define_method(:m6){ x }; }; klass.new.method(:m6)").to_source }.
        should.raise(Sourcify::CannotParseEvalCodeError)
    end
  end

end
