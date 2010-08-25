require 'irb/ruby-lex'
require 'irb/ruby-token'

module ToSource
  module Proc

    class Lexer18

      # Implementation of this class has been inspired by the discussion at
      # http://www.justskins.com/forums/breaking-ruby-code-into-117453.html

      include Lexable

      def initialize(io, file, line)
        @file, @line, @io, @pos = file, line, io, io.pos
        @lex = RubyLex.new
        @lex.set_input(@io)
        @lex.get_readed
      end

      def lex
        (@tokens = []).extend(Extensions)

        while @tk = @lex.token
          tkc = @tk.class.to_s.sub(/\ARubyToken::/, '').downcase.to_sym
          begin
            @tokens << [@tk.line_no, @tk.char_no, tkc]
            send(:"on_#{tkc}")
            puts '', 'ok %s (%s,%s)' % ["on_#{tkc}", @tk.line_no, @tk.char_no]
          rescue NoMethodError
            puts '', 'missing %s (%s,%s)' % ["on_#{tkc}", @tk.line_no, @tk.char_no]
          end
          @lex.get_readed if tkc == :tknl
        end
      end

      def on_tknl
        raise EndOfLine unless @results.empty?
      end

      def on_tkdo
        if !@do_end_counter.started?
          @do_end_counter.marker = @tk.seek
          @do_end_counter.increment_start
        elsif @tokens.same_as_curr_line.keywords(:tkfor, :tkwhile, :tkuntil).empty?
          # It is possible for a 'for', 'while' or 'until' to have an attached 'do',
          # for such a case, we want to skip it
          @do_end_counter.increment_start
        end
      end

      def on_tkend
        if @do_end_counter.started? && @do_end_counter.increment_end.telly?
          @result = grab_result_and_reset_lex(@do_end_counter.marker, 3)
          @is_multiline_block = @tokens.multiline?
          raise EndOfBlock
        end
      end

      def on_tkclass
        # Pretty straightforward for these, each of them will consume an 'end' close it
        @do_end_counter.increment_start if @do_end_counter.started?
      end

      # These work the same as 'class', the exception is 'for', which can have an optional
      # 'do' attached:
      # * for a in [1,2] do ... end
      # * for a in [1,2] \n ... end
      %w{def module begin case for}.each{|kw| alias_method :"on_tk#{kw}", :on_tkclass }

      def on_tkwhile
        # This has optional trailing 'do', and can work as a modifier as well, eg:
        # * while true do ... end # => 'do' must be on the same line as 'while'
        # * while true \n ... end
        # * ... while true # => 'while' is pre-pended with non-spaces
        if @do_end_counter.started? && (@tokens.start_of_line? or @tokens.within_block?)
          @do_end_counter.increment_start
        end
      end

      # These work exactly the same as 'while'.
      %w{until if unless}.each{|kw| alias_method :"on_tk#{kw}", :on_tkwhile }

      def on_tklbrace
        unless @do_end_counter.started?
          @braced_counter.marker = @tk.seek unless @braced_counter.started?
          @braced_counter.increment_start
        end
      end

      def on_tkrbrace
        if @braced_counter.started? && @braced_counter.increment_end.telly?
          @result = grab_result_and_reset_lex(@braced_counter.marker, 1)
          @is_multiline_block = @tokens.multiline?
          raise EndOfBlock
        end
      end

      alias_method :on_tkflbrace, :on_tklbrace
      alias_method :on_tkfrbrace, :on_tkrbrace

      def on_tkassoc
        if @braced_counter.started? && @braced_counter[:start] == 1
          @braced_counter.decrement_start
        end
      end

      def on_tkgt
        on_tkassoc if @tokens[-2 .. -1].map(&:last) == [:tkassign, :tkgt]
      end

      def grab_result_and_reset_lex(marker, offset)
        @io.seek(@pos+marker)
        result = @io.read(diff = @tk.seek - marker + offset)
        @io.seek(@pos + diff)
        @lex.set_input(@io)
        @lex.get_readed
        result
      end

      # Ease working with the hybrid token set collected from RubyLex
      module Extensions

        ROW, COL, TYP = 0, 1, 2

        def same_as_curr_line
          same_line(curr_line)
        end

        def multiline?
          self[0][ROW] != self[-1][ROW]
        end

        def curr_line
          curr[ROW]
        end

        def curr
          self[-1]
        end

        def same_line(line)
          (
            # ignore the current node
            self[0..-2].reverse.take_while do |e|
              if e[TYP] == :tsemi
                false
              elsif e[ROW] == line
                true
              elsif e[ROW] == line.pred && e[TYP] != :tknl
                line -= 1
                puts '', 'yup (%s)' % line
                true
              end
            end.reverse
          ).extend(Extensions)
        end

        def keywords(*types)
          (
            types = [types].flatten
            select{|e| types.include?(e[TYP]) }
          ).extend(Extensions)
        end

        def non_spaces(*types)
          (
            types = [types].flatten
            reject{|e| types.empty? or types.include?(e[TYP]) }
          ).extend(Extensions)
        end

        def start_of_line?
          same_as_curr_line.non_spaces.empty?
        end

        def within_block?
          [:tLPAREN, :tLPAREN2].include?(same_as_curr_line.non_spaces[-1][TYP])
        end

      end

    end
  end
end
