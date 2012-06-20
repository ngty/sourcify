Sourcify.require_rb('method', 'parser', 'raw_scanner')

module Sourcify
  module Method
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
            when 0 then raise NoMatchingMethodError
            when 1 then results[0]
            else raise MultipleMatchingMethodsPerLineError
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
                *rscan(
                  outer[0].sub(/^def(.*)end$/,'\1').sub(/^(?:.*?)(def.*)$/,'\1'),
                  inner_opts
                )
              ]
            end.flatten(1)
          end

        end
      end
    end
  end
end
