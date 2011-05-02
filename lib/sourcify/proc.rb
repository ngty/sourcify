module Sourcify

  class MultipleMatchingProcsPerLineError < Exception; end
  class NoMatchingProcError < Exception; end
  class ParserInternalError < Exception; end
  class CannotParseEvalCodeError < Exception; end
  class CannotHandleCreatedOnTheFlyProcError < Exception; end

  module Proc

    def self.included(base) #:nodoc:
      base.class_eval do
        Sourcify.require_rb('proc', 'methods')
        include Methods::SourceLocation
        include Methods::ToRawSource
        include Methods::ToSource
        include Methods::ToSexp
      end
    end

    module Stubs

      ###
      # Returns the ruby source filename and line number containing this proc.
      #
      #   # /tmp/test.rb
      #   x = lambda { 1 }
      #   x.source_location # >> ["/tmp/test.rb", 2]
      #
      # When proc is not defined in ruby (i.e. native), or when the proc is created using
      # Method#to_proc or Symbol#to_proc, nil is returned.
      #
      #   class AA
      #     class << self
      #       def m1; 1; end
      #       def m2(&block); block; end
      #     end
      #   end
      #
      #   AA.method(:m1).to_proc.source_location # >> nil
      #   AA.m2(&:m1).source_location            # >> nil
      #
      # For 1.9.2, the proc obtained using Method#to_proc by default yields info pointing
      # to where the method is located. Sourcify respects this builtin implementation and
      # assumes you usually want it. It is possible to get info that is consistent with all
      # other rubies by passing in +get_original+ as false:
      #
      #   # /tmp/test.rb
      #   class AA
      #     def m; 1; end
      #   end
      #
      #   x = AA.new.method(:m).to_proc
      #   x.source_location        # >> ["/tmp/test.rb", 2]
      #   x.source_location(false) # >> nil
      #
      def source_location(get_original = true)
        # NOTE: this is a stub for the actual one in Methods::SourceLocation
      end

      ###
      # Returns the code representation of this proc. Unlike Proc#to_raw_source, the
      # returned code retains only the functional aspects, fluff like comments are
      # stripped off.
      #
      #   lambda do |i|
      #     i+1 # (blah)
      #   end.to_source
      #   # >> "proc {|i| i+1 }"
      #
      # The following options are supported:
      #
      # * +:strip_enclosure+ when set to true, strips the enclosing "proc { ... }" to get
      #   just the meat within.
      #
      #     lambda {|i| i+1 }.to_source(:strip_enclosure => true)
      #     # >> "i+2"
      #
      #   (this option is effective regardless of presence of ParseTree)
      #
      # * +:attached_to+ is useful to avoid the nasty
      #   Sourcify::MultipleMatchingProcsPerLineError (as a result of ambiguities when doing
      #   static code analysis), it declares the condition that must be met prior grabbing
      #   the code block:
      #
      #     x = lambda { proc { :blah } }
      #
      #     x.to_source
      #     # >> Sourcify::MultipleMatchingProcsPerLineError
      #
      #     x.to_source(:attached_to => :lambda)
      #     # >> "proc { proc { :blah } }"
      #
      #   Sometimes more control is needed:
      #
      #     # We want to ignore everything associated with ignore
      #     def ignore(&block); block; end
      #     x = lambda { ignore { :blah } }
      #
      #     x.to_source
      #     # >> Sourcify::MultipleMatchingProcsPerLineError
      #
      #     x.to_source(:attached_to => /^(.*\W|)(lambda|proc)\W/)
      #     # >> "proc { ignore { :blah } }"
      #
      #   (this option is effective ONLY when ParseTree is not available)
      #
      # * +:ignore_nested+ is useful when only the outermost proc matters and we want to
      #   ignore all other nested proc(s):
      #
      #     x = lambda { lambda { :blah } }
      #
      #     x.to_source
      #     # >> Sourcify::MultipleMatchingProcsPerLineError
      #
      #     x.to_source(:ignore_nested => true)
      #     # >> "proc { lambda { :blah } }"
      #
      #   However, since code scanning stops at the outermost proc, beware of the following:
      #
      #     x = lambda {|_| lambda { lambda { :blah } } }.call(nil)
      #
      #     x.to_source
      #     # >> "proc { lambda { :blah } }"
      #
      #     x.to_source(:ignore_nested => true)
      #     # >> Sourcify::NoMatchingProcError
      #
      #   (this option is effective ONLY when ParseTree is not available)
      #
      # When in static code analysis (non-ParseTree) mode, it is even possible to
      # specify how the proc body should look like by passing in a code block:
      #
      #     x, y = lambda { def secret; 1; end }, lambda { :blah }
      #
      #     x.to_source
      #     # >> Sourcify::MultipleMatchingProcsPerLineError
      #
      #     x.to_source{|body| body =~ /^(.*\W|)def\W/ }
      #     # >> "proc { def secret; 1; end }"
      #
      def to_source(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSource
      end

      ###
      # Returns the S-expression representation of this proc.
      #
      #   lambda {|i| i+1 }.to_sexp
      #   # >> s(:iter,
      #   # >>   s(:call, nil, :proc, s(:arglist)),
      #   # >>   s(:lasgn, :i),
      #   # >>   s(:call, s(:lvar, :i), :+, s(:arglist, s(:lit, 1))))
      #
      # (pls see #to_source for options/arguments supported)
      #
      def to_sexp(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToSexp
      end

      ###
      # Returns the raw code enclosed within this proc.
      #
      #   lambda do |i|
      #     i+1 # (blah)
      #   end.to_source
      #   # >> "proc do |i|
      #   # >>   i+1 # (blah)
      #   # >> end"
      #
      # NOTE: The options supported are the same as those for Proc#to_source.
      #
      def to_raw_source(opts={}, &body_matcher)
        # NOTE: this is a stub for the actual one in Methods::ToRawSource
      end

    end

  end

end

Proc.class_eval do
  include Sourcify::Proc
end
