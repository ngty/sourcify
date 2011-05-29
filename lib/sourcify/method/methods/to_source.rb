module Sourcify
  module Method
    module Methods #:nodoc:all
      module ToSource
        def self.included(base)
          base.class_eval do

            Sourcify.require_rb('method', 'parser')

            def to_source(opts = {}, &body_matcher)
              (@sourcified_parser ||= Parser.new(self)).
                source(opts.merge(:body_matcher => body_matcher))
            end

          end
        end
      end
    end
  end
end
