%w{normalizer scanner source_code converter}.each do |file|
  Sourcify.require_rb('proc', 'parser', file)
end

module Sourcify
  module Proc
    class Parser #:nodoc:all

      def initialize(_proc)
        @arity, @source_code = _proc.arity, SourceCode.new(*_proc.source_location(false))
        raise CannotHandleCreatedOnTheFlyProcError unless @source_code.file
        raise CannotParseEvalCodeError if @source_code.file == '(eval)'
        @binding = _proc.binding # this must come after the above check
      end

      def source(opts)
        (@sources ||= {})[opts.hash] ||= Converter.to_code(sexp(opts))
      end

      def sexp(opts)
        (@sexps ||= {})[opts.hash] ||= (
          extracted = extracted_source(opts)[1]
          raw_code = (("\n" * @source_code.line) + extracted).same_encoding_as(extracted)

          raw_sexp = Converter.to_sexp(raw_code, @source_code.file)
          sexp = Normalizer.process(raw_sexp, @binding)
          opts[:strip_enclosure] ? Sexp.from_array(sexp.to_a.last) : sexp
        )
      end

      def raw_source(opts)
        raw_code = extracted_source(opts)[0].strip
        opts[:strip_enclosure] ?
          raw_code.sub(/^proc\s*(\{|do)\s*(\|[^\|]+\|)?(.*)(\}|end)$/m, '\3').strip : raw_code
      end

      private

        def extracted_source(opts)
          Scanner.process(@source_code, opts) do |(raw, normalized)|
            begin
              eval(raw).arity == @arity
            rescue Exception
              raise ParserInternalError
            end
          end
        end

    end
  end
end
