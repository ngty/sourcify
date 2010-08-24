module ToSource
  module Proc
    class Parser19
      class Lexer < ::Ripper::Lexer

        class EndOfBlock < Exception ; end

        def initialize(fh, file, line)
          @file, @line = file, line
          super
        end

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
              @do_end_counter.increment_start if @do_end_counter.started?

            when 'for'
              # This has an optional trailing 'do', eg:
              # * for a in [1,2] do ... end
              # * for a in [1,2] \n ... end
              @do_end_counter.increment_start if @do_end_counter.started?

            when 'while', 'until', 'if', 'unless'
              # These have optional trailing 'do' (only for 'while' & 'until'), and can work
              # as a modifier as well, eg:
              # * while true do ... end # => 'do' must be on the same line as 'while'
              # * while true \n ... end
              # * ... while true # => 'while' is pre-pended with non-spaces
              if @do_end_counter.started?
                if rs.start_of_line? or rs.within_block?
                  @do_end_counter.increment_start
                end
              end

            when 'do'
              if !@do_end_counter.started?
                # The 1st 'do' on the line will mark the start of the proc (which may not
                # be true, but anyway, just do it for now, KISS !!
                @do_end_counter.marker = rs.curr
                @do_end_counter.increment_start

              elsif rs.same_as_curr_line.keywords(%w{for while until}).empty?
                # It is possible for a 'for', 'while' or 'until' to have an attached 'do',
                # for such a case, we want to skip it
                @do_end_counter.increment_start
              end

            when 'end'
              # Very straigtforward, every 'end' will be considered !!
              if @do_end_counter.started?
                if @do_end_counter.increment_end.telly?
                  @result = rs.to_code(@do_end_counter.marker)
                  raise EndOfBlock
                end
              end

            end
          end
        end

        def on_rbrace(token)
          super.tap do |rs|
            break if @do_end_counter.started? or !@braced_counter.started?
            if @braced_counter.increment_end.telly?
              rs.extend(Extensions::Result) unless rs.respond_to?(:curr)
              @result = rs.to_code(@braced_counter.marker)
              raise EndOfBlock
            end
          end
        end

        def on_lbrace(token)
          super.tap do |rs|
            break if @do_end_counter.started?
            rs.extend(Extensions::Result) unless rs.respond_to?(:curr)
            @braced_counter.marker = rs.curr unless @braced_counter.started?
            @braced_counter.increment_start
          end
        end

        def on_op(token)
          super.tap do |rs|
            break if @do_end_counter.started? or !@braced_counter.started?
            @braced_counter.decrement_start if token == '=>' && @braced_counter[:start] == 1
          end
        end

        def on_label(token)
          super.tap do |rs|
            rs.extend(Extensions::Result) unless rs.respond_to?(:curr)
            break if @do_end_counter.started? or !@braced_counter.started?
            @braced_counter.decrement_start if @braced_counter[:start] == 1
          end
        end

      end

    end
  end
end
