module ToSource
  module Proc
    class Parser19
      class Lexer < ::Ripper::Lexer

        class EndOfBlock < Exception ; end
        class EndOfLine  < Exception ; end

        def lex
          begin
            @do_end_counter = Counters::DoEndBlock.new
            @braced_counter = Counters::BracedBlock.new
            super
          rescue EndOfBlock
            (@results ||= []) << @result.dup
            @is_multiline_block ? @results : retry
          rescue EndOfLine
            @results
          end
        end

        def on_nl(token)
          super.tap do |rs|
            raise EndOfLine unless @results.empty?
          end
        end

        def on_kw(token)
          super.tap do |rs|
            send(:"on_kw_#{token}", rs) rescue NoMethodError
          end
        end

        def on_kw_class(rs)
          # Pretty straightforward for these, each of them will consume an 'end' close it
          @do_end_counter.increment_start if @do_end_counter.started?
        end

        # These work the same as 'class', the exception is 'for', which can have an optional
        # 'do' attached:
        # * for a in [1,2] do ... end
        # * for a in [1,2] \n ... end
        %w{def module begin case for}.each{|kw| alias_method :"on_kw_#{kw}", :on_kw_class }

        def on_kw_while(rs)
          # This has optional trailing 'do', and can work as a modifier as well, eg:
          # * while true do ... end # => 'do' must be on the same line as 'while'
          # * while true \n ... end
          # * ... while true # => 'while' is pre-pended with non-spaces
          if @do_end_counter.started? && (rs.start_of_line? or rs.within_block?)
            @do_end_counter.increment_start
          end
        end

        # These work exactly the same as 'while'.
        %w{until if unless}.each{|kw| alias_method :"on_kw_#{kw}", :on_kw_while }

        def on_kw_do(rs)
          if !@do_end_counter.started?
            rs.extend(Extensions::Result) unless rs.respond_to?(:curr)
            @do_end_counter.marker = rs.curr
            @do_end_counter.increment_start
          elsif rs.same_as_curr_line.keywords(%w{for while until}).empty?
            # It is possible for a 'for', 'while' or 'until' to have an attached 'do',
            # for such a case, we want to skip it
            @do_end_counter.increment_start
          end
        end

        def on_kw_end(rs)
          if @do_end_counter.started? && @do_end_counter.increment_end.telly?
            @result = rs.to_code(@do_end_counter.marker)
            @is_multiline_block = rs.multiline?
            raise EndOfBlock
          end
        end

        def on_lbrace(token)
          super.tap do |rs|
            unless @do_end_counter.started?
              rs.extend(Extensions::Result) unless rs.respond_to?(:curr)
              @braced_counter.marker = rs.curr unless @braced_counter.started?
              @braced_counter.increment_start
            end
          end
        end

        def on_rbrace(token)
          super.tap do |rs|
            if @braced_counter.started? && @braced_counter.increment_end.telly?
              @result = rs.to_code(@braced_counter.marker)
              @is_multiline_block = rs.multiline?
              raise EndOfBlock
            end
          end
        end

        def on_op(token)
          super.tap do |rs|
            if @braced_counter.started? && token == '=>' && @braced_counter[:start] == 1
              @braced_counter.decrement_start
            end
          end
        end

        def on_label(token)
          super.tap do |rs|
            if @braced_counter.started? && @braced_counter[:start] == 1
              @braced_counter.decrement_start
            end
          end
        end

      end

    end
  end
end
