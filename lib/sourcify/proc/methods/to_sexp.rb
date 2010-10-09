module Sourcify
  module Proc
    module Methods
      module ToSexp
        def self.included(base)
          base.class_eval do

            ref_proc = lambda {}

            # Case 1: we already have Proc#to_sexp (provided by ParseTree) available, we just
            # override it to ensure passing in extra args won't break it.
            if ref_proc.respond_to?(:to_sexp)

              alias_method :__pre_sourcified_to_sexp, :to_sexp

              def to_sexp(opts = {})
                __pre_sourcified_to_sexp
              end

            # Case 2: okko, we have to implement our own Proc#to_sexp ...
            else

              def to_sexp(opts = {})
                Sourcify.require_rb('proc', 'parser')
                (@parser ||= Parser.new(self, opts)).sexp
              end

            end
          end
        end
      end
    end
  end
end
