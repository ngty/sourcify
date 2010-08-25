require 'to_source/proc/counter'
require 'to_source/proc/lexable'
require 'to_source/proc/lexer18'

module ToSource
  module Proc
    class Parser18

      attr_reader :file, :line, :lexer

      def initialize(_proc)
        @file, line = /^#<Proc:0x[0-9A-Fa-f]+@(.+):(\d+).*?>$/.match(_proc.inspect)[1..2]
        @line, @lexer = line.to_i, Lexer18
      end

    end
  end
end
