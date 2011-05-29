module Sourcify
  module Method
    module Methods #:nodoc:all
      module ToSexp
        def self.included(base)
          base.class_eval do

            Sourcify.require_rb('method', 'parser')

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
