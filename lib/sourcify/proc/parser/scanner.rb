Sourcify.require_rb('proc', 'parser', 'raw_scanner')

module Sourcify
  module Proc
    class Parser #:nodoc:all
      class Scanner
        class << self

          def process(source_code, opts, &matcher)
            results = rscan(source_code.to_s, {
              :start_pattern => scan_pattern_hint(opts[:attached_to]),
              :body_matcher => opts[:body_matcher],
              :ignore_nested => opts[:ignore_nested],
              :stop_on_newline => false,
            }).select{|(raw, normalized)| matcher.call(raw) }

            case results.size
            when 0 then raise NoMatchingProcError
            when 1 then results[0]
            else raise MultipleMatchingProcsPerLineError
            end
          end

          def scan_pattern_hint(val)
            case val
            when Regexp then val
            when String, Symbol then /^(?:.*?\W|)#{val}(?:\W)/
            when nil then /.*/
            else raise TypeError
            end
          end

          def rscan(str, opts)
            results = RawScanner.process(str, opts) || []
            inner_opts = opts.merge(:stop_on_newline => true)
            return results if opts[:ignore_nested]
            results.map do |outer|
              [
                outer,
                *rscan(outer[1].sub(/^proc\s*(do|\{)/,''), inner_opts)
              ]
            end.flatten(1)
          end

        end
      end
    end
  end
end
