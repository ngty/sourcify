Sourcify.require_rb('proc', 'scanner')

module Sourcify
  module Proc
    class Parser #:nodoc:all

      RUBY_PARSER = RubyParser.new
      RUBY_2_RUBY = Ruby2Ruby.new

      IS_19x = RUBY_VERSION.include?('1.9.')
      IS_JAVA = RUBY_PLATFORM =~ /java/i
      SYMBOL_TO_PROC_SRC = '/lib/ruby/site_ruby/shared/builtin/core_ext/symbol.rb'

      def initialize(_proc)
        @arity, @source_code = _proc.arity, SourceCode.new(*_proc.source_location)
        raise CannotHandleCreatedOnTheFlyProcError unless @source_code.file
        @binding = _proc.binding # this must come after the above check
        case @source_code.file
        when /\(eval\)/ then raise CannotParseEvalCodeError
        when /\(irb\)/ then raise CannotParseIrbCodeError
        end
      end

      def source
        @source ||= RUBY_2_RUBY.process(Sexp.from_array(sexp.to_a))
      end

      def sexp
        @sexp ||= (
          raw_sexp = RUBY_PARSER.parse(raw_source, @source_code.file)
          Sexp.from_array(Normalizer.process(raw_sexp, @binding))
        )
      end

      private

        def raw_source
          CodeScanner.process(@source_code) do |code|
            begin
              eval(code).arity == @arity
            rescue Exception
              p $!
              raise ParserInternalError
            end
          end
        end

        class Normalizer
          class << self

            def process(sexp, binding)
              @binding = binding
              fix_no_arg_method_calls(sexp.to_a)
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

            def process(source_code, &matcher)
              result = rscan(source_code.to_s, false).flatten.select(&matcher)
              case result.size
              when 1 then ("\n" * source_code.line) + result[0]
              else raise MultipleMatchingProcsPerLineError
              end
            end

            def rscan(str, stop_on_newline)
              (Scanner.process(str, stop_on_newline) || []).map do |outer|
                inner = outer.is_a?(Symbol) ? [] : rscan(outer.sub(/^proc\s*(do|\{)/,''), true)
                [outer, inner]
              end
            end

          end
        end

        class SourceCode < Struct.new(:file, :line)

          def line
            super.pred
          end

          def to_s
            File.open(file, 'r') do |fh|
              fh.extend(File::Tail)
              fh.forward(line)
              fh.readlines.join
            end
          end

        end

    end
  end
end
