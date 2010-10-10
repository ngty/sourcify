Sourcify.require_rb('proc', 'scanner')

module Sourcify
  module Proc
    class Parser #:nodoc:all

      RUBY_PARSER = RubyParser.new
      RUBY_2_RUBY = Ruby2Ruby.new

      IS_19x = RUBY_VERSION.include?('1.9.')

      def initialize(_proc)
        @arity, @source_code = _proc.arity, SourceCode.new(*_proc.source_location(false))
        raise CannotHandleCreatedOnTheFlyProcError unless @source_code.file
        raise CannotParseEvalCodeError if @source_code.file == '(eval)'
        @binding = _proc.binding # this must come after the above check
      end

      def source(opts)
        (@sources ||= {})[opts.hash] ||=
          RUBY_2_RUBY.process(Sexp.from_array(sexp(opts).to_a))
      end

      def sexp(opts)
        (@sexps ||= {})[opts.hash] ||= (
          raw_sexp = RUBY_PARSER.parse(raw_source(opts), @source_code.file)
          sexp = Normalizer.process(raw_sexp, @binding)
          opts[:strip_enclosure] ? Sexp.from_array(sexp.to_a.last) : sexp
        )
      end

      private

        def raw_source(opts)
          (@raw_sources ||= {})[opts[:attached_to] || false] ||=
            CodeScanner.process(@source_code, opts) do |code|
              begin
                eval(code).arity == @arity
              rescue Exception
                raise ParserInternalError
              end
            end
        end

        class Normalizer
          class << self

            def process(sexp, binding)
              @binding = binding
              Sexp.from_array(fix_no_arg_method_calls(sexp.to_a))
            end

            def fix_no_arg_method_calls(array)
              return array if [:class, :sclass, :defn, :module].include?(array[0])
              array.map do |e|
                if e.is_a?(Array)
                  no_arg_method_call?(e) or fix_no_arg_method_calls(e)
                else
                  e
                end
              end
            end

            def no_arg_method_call?(e)
              if like_no_arg_method_call?(e)
                bounded_var?(var = e[2]) ? [:lvar, var] : e
              end
            end

            def like_no_arg_method_call?(e)
              e.size == 4 && e[0..1] == [:call, nil] &&
                e[3] == [:arglist] && (var = e[2]).is_a?(Symbol)
            end

            def bounded_var?(var)
              qvar = (@q ||= (IS_19x ? ":%s" : "'%s'")) % var
              @binding.eval("local_variables.include?(#{qvar})")
            end

          end
        end

        class CodeScanner
          class << self

            def process(source_code, opts, &matcher)
              pattern = scan_pattern_hint(opts[:attached_to])
              results = rscan(source_code.to_s, pattern, false).flatten.select(&matcher)
              case results.size
              when 0 then raise NoMatchingProcError
              when 1 then ("\n" * source_code.line) + results[0]
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

            def rscan(str, pattern, stop_on_newline)
              (Scanner.process(str, pattern, stop_on_newline) || []).map do |outer|
                [outer, rscan(outer.sub(/^proc\s*(do|\{)/,''), pattern, true)]
              end
            end

          end
        end

        class SourceCode < Struct.new(:file, :line)

          def line
            super.pred
          end

          def to_s
            case file
            when /\(irb\)/ then from_irb_to_s
            else from_file_to_s
            end
          end

          def from_file_to_s
            File.open(file, 'r') do |fh|
              fh.extend(File::Tail).forward(line)
              fh.readlines.join
            end
          end

          def from_irb_to_s
            # Really owe it to Florian Groß's solution @ http://rubyquiz.com/quiz38.html ...
            # anyway, note that we use *line.succ* instead of *line* here.
            IRB.CurrentContext.io.line(line.succ .. -1).join
          end

        end

    end
  end
end
