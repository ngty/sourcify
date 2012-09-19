module Sourcify
  module Proc
    module Extractor
      module Block
        class LambdaOp < Base

          attr_reader :block

          def initialize(*args)
            @block = nil
            super
          end

          def <<(token)
            if @block
              @block << token
            else
              case token.evt
              when :tlambeg then @block = Brace.new(@type, token)
              when :kw_do then @block = DoEnd.new(@type, token)
              else super
              end
            end
          end

          def lambda_op?
            true
          end

          def done?
            @done ||=
              if @block && @block.done?
                !!(@body = finalize(indented_body))
              end
          end

          def body
            @body
          end

        private

          def indented_body
            tokens, body = self.tokens, @block.body.sub(/^lambda\ +/,'')
            start = @block.is_a?(Brace) ? '{' : 'do'

            params =
              if tokens[1].lparen?
                i_rparen = tokens.rindex(&:rparen?)
                t_evts = tokens[(i_rparen-2) ... i_rparen].map(&:evt)

                if t_evts == [:nl, :sp]
                  tokens[i_rparen-2].frag = "\\\n"
                elsif t_evts[-1] == :nl
                  tokens[i_rparen-1].frag = "\\\n"
                end

                tokens[2 ... i_rparen].map {|t| t.frag(@block.indent) }.join
              end

            if params
              body.sub(start, "#{start} |#{params}|")
            else
              body
            end
          end

        end
      end
    end
  end
end
