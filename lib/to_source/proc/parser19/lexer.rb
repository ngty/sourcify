module ToSource
  module Proc
    class Parser19
      class Lexer < ::Ripper::Lexer

        class EndOfBlock < Exception ; end

        def lex
          begin
            super
          rescue EndOfBlock
            return @result
          end
        end

        def on_kw(token)
          super.tap do |rs|
            case token
            when 'do'
              @do_block_start = rs[-1] if @kw_block.nil?
              (@kw_block ||= []) << token
            when 'end'
              unless (@kw_block ||= []).empty?
                @kw_block << token
                if @kw_block.grep(/end/).size == @kw_block.grep(/do/).size
                  @result = rs[rs.index(@do_block_start) .. -1]
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
