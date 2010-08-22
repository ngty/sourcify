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
            case token
            when 'class', 'def', 'module', 'begin', 'if', 'unless', 'case'
              # Pretty straightforward for these, each of them will consume an 'end' to
              # mark it closed
              @do_end_counter.increment_start unless @do_end_counter.fresh?
            when 'do'
              @do_end_counter.marker = rs[-1] if @do_end_counter.fresh?
              @do_end_counter.increment_start
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
