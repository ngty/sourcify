Sourcify.require_rb('proc', 'scanner')

module Sourcify
  module Proc
    class Parser #:nodoc:all

      RUBY_PARSER = RubyParser.new
      RUBY_2_RUBY = Ruby2Ruby.new

      def initialize(_proc)
        @binding, @arity = _proc.binding, _proc.arity
        @file, @line = _proc.source_location
        raise CannotParseEvalCodeError if @file == '(eval)'
      end

      def source
        RUBY_2_RUBY.process(Sexp.from_array(sexp.to_a))
      end

      def sexp
        @sexp ||= (
          raw_sexp = RUBY_PARSER.parse(raw_source, @file)
          Sexp.from_array(replace_with_lvars(raw_sexp.to_a))
        )
      end

      private

        def raw_source
          @raw_source ||=
            if (frags = raw_source_frags).size > 1
              raise MultipleMatchingProcsPerLineError
            else
              # Cheapo hack to ensure __LINE__ is correctly represented !!
              ("\n" * @line.pred) + frags[0]
            end
        end

        def raw_source_frags
          begin
            Scanner.process(
              Parsable.open(@file, 'r'){|fh| fh.forward(@line.pred).readlines.join }
            ).select{|code| eval(code).arity == @arity }
          rescue Exception
            raise ParserInternalError
          end
        end

        def replace_with_lvars(array)
          return array if [:class, :sclass, :defn, :module].include?(array[0])
          array.map do |e|
            if e.is_a?(Array)
              no_arg_method_call_or_lvar(e) or replace_with_lvars(e)
            else
              e
            end
          end
        end

        def no_arg_method_call_or_lvar(e)
          if represents_no_arg_call?(e)
            has_as_local_var?(var = e[2]) ? [:lvar, var] : e
          end
        end

        def represents_no_arg_call?(e)
          e.size == 4 && e[0..1] == [:call, nil] &&
            e[3] == [:arglist] && (var = e[2]).is_a?(Symbol)
        end

        def has_as_local_var?(var)
          qvar = (@q ||= (RUBY_VERSION.include?('1.9.') ? ":%s" : "'%s'")) % var
          @binding.eval("local_variables.include?(#{qvar})")
        end

        class Parsable < File
          include File::Tail
        end

    end
  end
end
