module ToSource
  module Proc
    module Lexable

      class EndOfBlock < Exception ; end
      class EndOfLine < Exception ; end

      def work
        begin
          @results ||= []
          @do_end_counter = Counter.new
          @braced_counter = Counter.new
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
