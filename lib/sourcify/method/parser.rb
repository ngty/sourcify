%w{scanner source_code converter}.each do |file|
  Sourcify.require_rb('method', 'parser', file)
end

module Sourcify
  module Method
    class Parser #:nodoc:all

      def initialize(_meth)
        @arity, @parameters, @name = _meth.arity, _meth.parameters, _meth.name
        @source_code = SourceCode.new(*_meth.source_location)
      end

      def source(opts)
        (@sources ||= {})[opts.hash] ||= Converter.to_code(sexp(opts))
      end

      def sexp(opts)
        (@sexps ||= {})[opts.hash] ||= (
          raw_code = ("\n" * @source_code.line) + extracted_source(opts)
          Converter.to_sexp(raw_code, @source_code.file)
        )
      end

      private

        def extracted_source(opts)
          Scanner.process(@source_code, opts) do |code|
            begin
              meth = Object.new.instance_eval("#{code}; self").method(@name)
              meth.arity == @arity && meth.parameters == @parameters
            rescue NameError
              false
            rescue Exception
              raise ParserInternalError
            end
          end
        end

    end
  end
end
