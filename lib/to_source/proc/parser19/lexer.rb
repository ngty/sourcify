module ToSource
  module Proc
    class Parser19
      class Lexer < ::Ripper::Lexer

        class EndOfBlock < Exception ; end

        def lex
          begin
            @do_end_counter = Counters::DoEndBlock.new
            @braced_counter = Counters::BracedBlock.new
            super
          rescue EndOfBlock
            return @result
          end
        end

        def on_kw(token)
          super.tap do |rs|
            rs.extend(Extensions::Result) unless rs.respond_to?(:curr)

            case token

            when 'class', 'def', 'module', 'begin', 'case'
              # Pretty straightforward for these, each of them will consume an 'end' close it
              @do_end_counter.increment_start unless @do_end_counter.fresh?

            when 'for'
              # This has an optional trailing 'do', eg:
              # * for a in [1,2] do ... end
              # * for a in [1,2] \n ... end
              @do_end_counter.increment_start unless @do_end_counter.fresh?

            when 'while', 'until', 'if', 'unless'
              # These have optional trailing 'do' (only for 'while' & 'until'), and can work
              # as a modifier as well, eg:
              # * while true do ... end # => 'do' must be on the same line as 'while'
              # * while true \n ... end
              # * ... while true # => 'while' is pre-pended with non-spaces
              unless @do_end_counter.fresh?
                @do_end_counter.increment_start if rs.same_as_curr_line.non_spaces.empty?
              end

            when 'do'
              if @do_end_counter.fresh?
                @do_end_counter.marker = rs.curr
                @do_end_counter.increment_start
              elsif rs.same_as_curr_line.keywords(%w{for while until}).empty?
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

      end

    end
  end
end
