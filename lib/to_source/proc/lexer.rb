module ToSource
  module Proc
    module Lexer

      class << self
        def new(*args)
          begin
            require 'to_source/proc/lexer19'
            Lexer19.new(*args)
          rescue LoadError
            require 'to_source/proc/lexer18'
            Lexer18.new(*args)
          end
        end
      end

      module Commons

        class EndOfBlock < Exception ; end
        class EndOfLine < Exception ; end

        def work
          begin
            @results ||= []
            @do_end_counter = ToSource::Proc::Counter.new
            @braced_counter = ToSource::Proc::Counter.new
            lex
          rescue EndOfBlock
            @results << @result.dup
            @is_multiline_block ? @results : retry
          rescue EndOfLine
            @results
          end
        end

      end

    end
  end
end
