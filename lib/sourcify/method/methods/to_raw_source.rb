module Sourcify
  module Method
    module Methods #:nodoc:all
      module ToRawSource
        def self.included(base)
          base.class_eval do

            Sourcify.require_rb('method', 'parser')

            if IS_PLATFORM_SUPPORTED

              def to_raw_source(opts = {}, &body_matcher)
                (@sourcified_parser ||= Parser.new(self)).
                  raw_source(opts.merge(:body_matcher => body_matcher))
              end

            else

              def to_raw_source(*args)
                raise PlatformNotSupportedError
              end

            end

          end
        end
      end
    end
  end
end
