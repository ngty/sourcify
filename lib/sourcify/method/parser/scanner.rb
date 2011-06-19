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
            }).flatten.select(&matcher)
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
            return results if opts[:ignore_nested]
            results.map do |outer|
              inner = rscan(
                outer.sub(/^def(.*)end$/,'\1').sub(/^(?:.*?)(def.*)$/,'\1'),
                opts.merge(:stop_on_newline => true)
              )
              [outer, inner]
            end
          end

        end
      end
    end
  end
end
