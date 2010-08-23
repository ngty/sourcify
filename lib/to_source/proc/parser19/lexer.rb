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
            rs.extend(Extensions) unless rs.respond_to?(:curr)

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
              # These can work as modifier as well, eg:
              # * if true then ... end
              # * ... if true

            when 'while', 'until'
              # These have optional trailing 'do', can can work as a modifier as well, eg:
              # * while true do ... end # => 'do' must be on the same line as 'while'
              # * while true \n ... end
              # * ... while true
              @do_end_counter.increment_start unless @do_end_counter.fresh?

            when 'do'
              if @do_end_counter.fresh?
                @do_end_counter.marker = rs.curr
                @do_end_counter.increment_start
              elsif rs.same_as_curr_line.by_keywords(%w{for while until}).empty?
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


        module Extensions

          def same_as_curr_line
            same_line(curr_line)
          end

          def curr_line
            curr[0][0]
          end

          def curr
            self[-1]
          end

          def same_line(line)
            (
              reverse.take_while do |e|
                (e[0][0] == line) or (e[0][-1] == "\\\n" && line -= 1; true)
              end
            ).extend(Extensions)
          end

          def by_keywords(*words)
            (
              words = [words].flatten
              select{|e| e[1] == :on_kw && words.include?(e[-1]) }
            ).extend(Extensions)
          end

        end

      end

    end
  end
end
