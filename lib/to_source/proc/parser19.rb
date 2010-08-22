require 'ripper'
require 'file/tail'
require 'to_source/proc/parser19/lexer'

module ToSource
  module Proc
    class Parser19

      def initialize(_proc)
        @arity, (@file, @line) = _proc.arity, _proc.source_location
        @binding = _proc.binding
      end

      def source
        unless @source
          File.open(@file) do |fh|
            fh.extend(File::Tail)
            fh.forward(@line.pred)
            @source = 'proc ' + Parser19::Lexer.new(fh, @file, @line).lex.map(&:last).join
          end
        end
        @source
      end

      def sexp
        @sexp ||= (
          pattern = %r{s\(:call,\ nil,\ :(\w+),\ s\(:arglist\)\)}
          sexp_str = RubyParser.new.parse(source).inspect.gsub(pattern) do |s|
            suspect_var = s[pattern,1]
            @binding.eval("local_variables.include?(:#{suspect_var})") ?
              "s(:lvar, :#{suspect_var})" : s
          end
          eval(sexp_str) # TODO: is there a better way to create a sexp from string ??
        )
      end

    end
  end
end
