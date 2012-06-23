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
        raise CannotFindSourceLocationError unless @source_code.file
        raise CannotParseEvalCodeError if @source_code.file == '(eval)'
      end

      def raw_source(opts)
        raw_source = extracted_source(opts)[0].strip
        opts[:strip_enclosure] ? strip_raw_enclosure(raw_source) : raw_source
      end

      def source(opts)
        (@sources ||= {})[opts.hash] ||= Converter.to_code(sexp(opts))
      end

      def sexp(opts)
        (@sexps ||= {})[opts.hash] ||= (
          extracted = extracted_source(opts)[1]
          raw_code = (("\n" * @source_code.line) + extracted).same_encoding_as(extracted)

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
            extracted = extracted_source_from_proc(opts)
            matches = extracted.map{|s| s.match(pattern) }

            (
              if @parameters.empty?
                matches.map{|match| %Q(def #{@name}\n#{match[3]}\nend) }
              else
                args = matches[0][2].sub(/^\|([^\|]+)\|$/, '\1')
                matches.map{|match| %Q(def #{@name}(#{args})\n#{match[3]}\nend) }
              end
            ).map{|s| s.same_encoding_as(extracted[0]) }
          end
        end

        def extracted_source_from_method(opts)
          Scanner.process(@source_code, opts) do |(raw, normalized)|
            begin
              Object.new.instance_eval("#{raw}; self".same_encoding_as(raw)).
                method(@name).parameters == @parameters
            rescue NameError
              false
            rescue Exception
              raise ParserInternalError
            end
          end
        end

        def extracted_source_from_proc(opts)
          Proc::Parser::Scanner.process(@source_code, opts) do |raw|
            begin
              Object.new.instance_eval(%(
                (class << self; self; end).class_eval do
                  define_method(:#{@name}, &(#{raw}))
                end; self
              ).same_encoding_as(raw)).method(@name).parameters == @parameters
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
