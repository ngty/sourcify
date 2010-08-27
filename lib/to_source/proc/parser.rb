require 'file/tail'
require 'to_source/proc/lexer'
require 'to_source/proc/counter'

module ToSource
  module Proc
    class Parser

      RUBY_PARSER = RubyParser.new
      RUBY_2_RUBY = Ruby2Ruby.new

      class MultipleMatchingProcsPerLineError < Exception ; end

      def initialize(_proc)
        @binding, @arity = _proc.binding, _proc.arity
        @file, @line = _proc.source_location
      end

      def source
        RUBY_2_RUBY.process(sexp)
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
            File.open(@file) do |fh|
              fh.extend(File::Tail).forward(@line.pred)
              frags = ToSource::Proc::Lexer.new(fh, @file, @line).work.
                select{|frag| eval('proc ' + frag).arity == @arity }
              raise MultipleMatchingProcsPerLineError if frags.size > 1
              'proc %s' % frags[0]
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
            @binding.eval("local_variables.include?(:#{e[2]})") ? [:lvar, e[2]] : e
          else
            nil
          end
        end

        def represents_no_arg_call?(e)
          e.size == 4 && e[0..1] == [:call, nil] &&
            e[3] == [:arglist] && (var = e[2]).is_a?(Symbol)
        end

    end
  end
end
