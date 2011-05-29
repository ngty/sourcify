module Sourcify
  module Method

    def self.included(base) #:nodoc:
      base.class_eval do
        Sourcify.require_rb('method', 'methods')
        include Methods::SourceLocation
        include Methods::ToSource
        include Methods::ToSexp
      end
    end

    module Stubs

      def source_location(get_original = true)
        # NOTE: this is a stub for the actual one in Methods::SourceLocation
      end

      def to_source(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSource
      end

      def to_sexp(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSexp
      end

    end

  end
end

Method.class_eval do
  include Sourcify::Method
end
