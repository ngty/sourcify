%w{scanner source_code converter}.each do |file|
  Sourcify.require_rb('method', 'parser', file)
end

module Sourcify
  module Method
    class Parser #:nodoc:all

      class ProbablyDefinedByProc < Exception; end

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
          begin
            extracted_source_from_method(opts)
          rescue ProbablyDefinedByProc
            pattern = /^proc\s*(\{|do)\s*(\|[^\|]*\|)?(.+)(\}|end)$/m
            match = extracted_source_from_proc(opts).match(pattern)
            if @arity.zero?
              %Q(def #{@name}\n#{match[3]}\nend)
            else
              args = match[2].sub(/^\|([^\|]+)\|$/, '\1')
              %Q(def #{@name}(#{args})\n#{match[3]}\nend)
            end
          end
        end

        def extracted_source_from_method(opts)
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

        def extracted_source_from_proc(opts)
          Proc::Parser::Scanner.process(@source_code, opts) do |code|
            begin
              obj = Object.new
              (class << obj; self; end).class_eval(%Q(
                define_method(:#{@name}, &(#{code}))
              ))
              meth = obj.method(@name)
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
