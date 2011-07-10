%w{scanner source_code converter}.each do |file|
  Sourcify.require_rb('method', 'parser', file)
end

module Sourcify
  module Method
    class Parser #:nodoc:all

      class ProbablyDefinedByProc < Exception; end

      def initialize(_meth)
        @parameters, @name = _meth.parameters, _meth.name
        @source_code = SourceCode.new(*_meth.source_location)
      end

      def raw_source(opts)
        raw_source = extracted_source(opts).strip
        opts[:strip_enclosure] ? strip_raw_enclosure(raw_source) : raw_source
      end

      def source(opts)
        (@sources ||= {})[opts.hash] ||= Converter.to_code(sexp(opts))
      end

      def sexp(opts)
        (@sexps ||= {})[opts.hash] ||= (
          raw_code = ("\n" * @source_code.line) + extracted_source(opts)
          sexp = Converter.to_sexp(raw_code, @source_code.file)
          opts[:strip_enclosure] ? Sexp.from_array(sexp.to_a[-1]) : sexp
        )
      end

      private

        def strip_raw_enclosure(source)
          inner =
            if @parameters.empty?
              '\s*'
            else
              @parameters.map do |param|
                if name = param[1]
                  case param[0]
                  when :req then name
                  when :opt then "#{name}\s*=\s*.*?"
                  when :rest then "\\*#{name}"
                  end
                else
                  '\(.*?\)'
                end
              end.join('\s*,\s*')
            end
          pattern = %r{^def\s+#{@name}(?:(?:\(\s*#{inner}\s*\))|(?:\s+#{inner}\s+))?(.*)end$}m
          source.sub(pattern, '\1').strip
        end

        def extracted_source(opts)
          begin
            extracted_source_from_method(opts)
          rescue ProbablyDefinedByProc
            pattern = /^proc\s*(\{|do)\s*(\|[^\|]*\|)?(.+)(\}|end)$/m
            match = extracted_source_from_proc(opts).match(pattern)
            if @parameters.empty?
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
              Object.new.instance_eval("#{code}; self").
                method(@name).parameters == @parameters
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
              Object.new.instance_eval(%(
                (class << self; self; end).class_eval do
                  define_method(:#{@name}, &(#{code}))
                end; self
              )).method(@name).parameters == @parameters
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
