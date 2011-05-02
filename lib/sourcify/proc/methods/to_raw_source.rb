module Sourcify
  module Proc
    module Methods #:nodoc:all
      module ToRawSource
        def self.included(base)
          base.class_eval do

            Sourcify.require_rb('proc', 'parser')

            def to_raw_source(opts = {}, &body_matcher)
              (@sourcified_parser ||= Parser.new(self)).
                raw_source(opts.merge(:body_matcher => body_matcher))
            end

          end
        end
      end
    end
  end
end
