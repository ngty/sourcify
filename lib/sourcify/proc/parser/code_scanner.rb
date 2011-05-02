module Sourcify
  module Proc
    class Parser #:nodoc:all
      class CodeScanner
        class << self

          def process(source_code, opts, &matcher)
            results = rscan(source_code.to_s, {
              :start_pattern => scan_pattern_hint(opts[:attached_to]),
              :body_matcher => opts[:body_matcher],
              :ignore_nested => opts[:ignore_nested],
              :stop_on_newline => false,
            }).flatten.select(&matcher)
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
            results = Scanner.process(str, opts) || []
            return results if opts[:ignore_nested]
            results.map do |outer|
              inner = rscan(outer.sub(/^proc\s*(do|\{)/,''), opts.merge(:stop_on_newline => true))
                [outer, inner]
              end
            end
          end

        end
      end
    end
  end
