require 'to_source/proc/counter'
require 'to_source/proc/lexer19'

module ToSource
  module Proc
    class Parser19

      attr_reader :file, :line, :lexer

      def initialize(_proc)
        @file, @line = _proc.source_location
        @lexer = Lexer19
      end

    end
  end
end
