module Sourcify

  class MultipleMatchingMethodsPerLineError < Exception; end
  class NoMatchingMethodError < Exception; end

  module Method

    def self.included(base) #:nodoc:
      base.class_eval do
        Sourcify.require_rb('method', 'methods')
        include Methods::ToSource
        include Methods::ToSexp
        include Methods::ToRawSource
      end
    end

    module Stubs

      def to_source(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSource
      end

      def to_sexp(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSexp
      end

      def to_raw_source(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToRawSource
      end

    end

  end
end

Method.class_eval do
  include Sourcify::Method
end
