module Sourcify
  module Proc
    module Methods #:nodoc:all
      module ToSexp
        def self.included(base)
          base.class_eval do

            ref_proc = lambda {}

            # Case 1: we already have Proc#to_sexp (eg. provided by ParseTree) available,
            # we override it to ensure it handles the extra args ..
            if ref_proc.respond_to?(:to_sexp)

              alias_method :__pre_sourcified_to_sexp, :to_sexp

              def to_sexp(opts = {}, &body_matcher)
                sexp, flag = __pre_sourcified_to_sexp, opts[:strip_enclosure]
                Marshal.load(Marshal.dump( # need a deep copy cos the caller may reset the sexp
                  (@sourcified_sexps ||= {})[flag] ||=
                    flag ? Sexp.from_array(sexp.to_a.last) : sexp
                ))
              end

            # Case 2: okko, we have to implement our own Proc#to_sexp ...
            else

              Sourcify.require_rb('proc', 'parser')

              def to_sexp(opts = {}, &body_matcher)
                (@sourcified_parser ||= Parser.new(self)).
                  sexp(opts.merge(:body_matcher => body_matcher))
              end

            end
          end
        end
      end
    end
  end
end
