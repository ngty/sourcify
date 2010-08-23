module ToSource
  module Proc
    class Parser19
      class Lexer < ::Ripper::Lexer

        class EndOfBlock < Exception ; end

        def lex
          begin
            @do_end_counter = DoEndBlockCounter.new
            @braced_counter = BracedBlockCounter.new
            super
          rescue EndOfBlock
            return @result
          end
        end

        def on_kw(token)
          super.tap do |rs|
            curr, curr_line = rs[-1], rs[-1][0][0]

            case token

            when 'class', 'def', 'module', 'begin', 'if', 'unless', 'case'
              # Pretty straightforward for these, each of them will consume an 'end' close it
              @do_end_counter.increment_start unless @do_end_counter.fresh?

            when 'for'
              # This has an optional trailing 'do', eg:
              # * for a in [1,2] do ... end
              # * for a in [1,2] \n ... end
              @do_end_counter.increment_start unless @do_end_counter.fresh?

            when 'if', 'unless'
              # These can work as modifier as well

            when 'while', 'until'
              # These have optional trailing 'do', can can work as a modifier as well
              # * while true do ... end
              # * while true \n ... end
              # * ... while true

            when 'do'
              if @do_end_counter.fresh?
                @do_end_counter.marker = curr
                @do_end_counter.increment_start
              elsif rs.reverse.
                take_while{|e| (e[0][0] == curr_line) or (e[0][-1] == "\\\n" && curr_line -= 1; true) }.
                select{|e| e[1] == :on_kw && %w{for while until}.include?(e[-1]) }.empty?
                  @do_end_counter.increment_start
              end
            when 'end'
              unless @do_end_counter.fresh?
                if @do_end_counter.increment_end.telly?
                  @result = rs[rs.index(@do_end_counter.marker) .. -1]
                  raise EndOfBlock
                end
              end
            end
          end
        end

#        def on_op(token)
#          super.tap do |rs|
#          end
#        end
#
#        def on_label(token)
#          super.tap do |rs
#          end
#        end
#
#        def on_rbrace(token)
#          super.tap do |rs|
#          end
#        end
#
#        def on_lbrace(token)
#          super.tap do |rs|
#          end
#        end

        class Counter

          attr_accessor :marker

          def initialize
            @marker, @counter = nil, {:start => 0, :end => 0}
          end

          def fresh?
            @counter.values == [0,0]
          end

          def telly?
            @counter[:start] == @counter[:end]
          end

          def increment_start
            @counter[:start] += 1
            self
          end

          def increment_end
            @counter[:end] += 1
            self
          end

        end

        class DoEndBlockCounter < Counter  ; end
        class BracedBlockCounter < Counter ; end

      end

    end
  end
end
