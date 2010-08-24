require 'ripper'
require 'file/tail'
require 'to_source/proc/parser19/counters'
require 'to_source/proc/parser19/extensions'
require 'to_source/proc/parser19/lexer'

module ToSource
  module Proc
    class Parser19

      RUBY_PARSER = RubyParser.new
      RUBY_2_RUBY = Ruby2Ruby.new

      def initialize(_proc)
        @arity, (@file, @line) = _proc.arity, _proc.source_location
        @binding = _proc.binding
      end

      def source
        RUBY_2_RUBY.process(sexp)
      end

      def sexp
        @sexp ||= (
          pattern = %r{s\(:call,\ nil,\ :(\w+),\ s\(:arglist\)\)}
          sexp_str = RUBY_PARSER.parse(raw_source, @file).inspect.gsub(pattern) do |s|
            suspect_var = s[pattern,1]
            @binding.eval("local_variables.include?(:#{suspect_var})") ?
              "s(:lvar, :#{suspect_var})" : s
          end
          eval(sexp_str) # TODO: is there a better way to create a sexp from string ??
        )
      end

      private

        def raw_source
          @raw_source ||=
            File.open(@file) do |fh|
              fh.extend(File::Tail)
              fh.forward(@line.pred)
              'proc ' + Parser19::Lexer.new(fh, @file, @line).lex
            end
        end

    end
  end
end
