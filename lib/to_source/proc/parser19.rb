require 'ripper'
require 'to_source/proc/parser19/counters'
require 'to_source/proc/parser19/extensions'
require 'to_source/proc/parser19/lexer'

module ToSource
  module Proc
    class Parser19

      class AmbiguousMatchError < Exception ; end

      attr_reader :file

      def initialize(_proc)
        @arity, (@file, @line) = _proc.arity, _proc.source_location
      end

      def raw_source
        @raw_source ||=
          File.open(@file) do |fh|
            fh.extend(File::Tail).forward(@line.pred)
            frags = Parser19::Lexer.new(fh, @file, @line).lex.
              select{|frag| eval('proc ' + frag).arity == @arity }
            raise AmbiguousMatchError if frags.size > 1
            'proc %s' % frags[0]
          end
      end

    end
  end
end
