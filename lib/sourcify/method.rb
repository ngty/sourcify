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

      ###
      # Returns the code representation of this method. Unlike Method#to_raw_source,
      # the returned code retains only the functional aspects, fluff like comments
      # are stripped off.
      #
      #   class MyMath
      #     def self.sum(x, y)
      #       x + y # (blah)
      #     end
      #   end
      #
      #   MyMath.method(:sum).to_source
      #   # >> "def sum(x, y)
      #   # >>   (x + y)
      #   # >> end"
      #
      # This works for method defined via Module#define_method as well. The following
      # approach of defining method yields exactly the same result as above:
      #
      #   class MyMath
      #     class << self
      #       define_method(:sum) do |x,y|
      #         x + y # (blah)
      #       end
      #     end
      #   end
      #
      #   MyMath.method(:sum).to_source
      #   # >> "def sum(x, y)
      #   # >>   (x + y)
      #   # >> end"
      #
      # The following options are supported:
      #
      # * +:strip_enclosure+ when set to true, strips the method enclosure to get
      #   just the meat within.
      #
      #     MyMath.method(:sum).to_source(:strip_enclosure => true)
      #     # >> "(x + y)"
      #
      # * +:attached_to+ is useful ONLY when a method is defined via
      #   Module#define_method, pls see Sourcify::Proc::Stubs#to_source for more info.
      #
      # * +:ignore_nested+ is useful ONLY when a method is defined via
      #   Module#define_method, pls see Sourcify::Proc::Stubs#to_source for more info.
      #
      # * an optional +body_matcher+ block is supported as well, again this is ONLY
      #   useful for method defined via Module#define_method, pls see
      #   Sourcify::Proc::Stubs#to_source for more info.
      #
      def to_source(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSource
      end

      ###
      # Returns the S-expression representation of this method.
      #
      #   class MyMath
      #     def self.sum(x, y)
      #       x + y # (blah)
      #     end
      #   end
      #
      #   MyMath.method(:sum).to_sexp
      #   >> s(:defn,
      #   >>  :sum,
      #   >>  s(:args, :x, :y),
      #   >>  s(:scope, s(:block, s(:call, s(:lvar, :x), :+, s(:arglist, s(:lvar, :y))))))
      #
      # This works for methods defined via Module#define_method as well. Pls see
      # #to_source for options/arguments supported.
      #
      def to_sexp(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSexp
      end

      ###
      # Returns the raw code enclosed within this method.
      #
      #   class MyMath
      #     def self.sum(x, y)
      #       x + y # (blah)
      #     end
      #   end
      #
      #   MyMath.method(:sum).to_raw_source
      #   >> "def sum(x, y)
      #   >>   x + y # (blah)
      #   >> end"
      #
      # This works for methods defined via Module#define_method as well. Pls see
      # #to_source for options/arguments supported.
      #
      def to_raw_source(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToRawSource
      end

    end

  end
end

Method.class_eval do
  include Sourcify::Method
end
