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
              if block && block.done?
                !!(@body = finalize(indented_body))
              end
          end

        private

          def indented_body
            body = block.body.sub(/^lambda\ +/,'')

            if params = extract_params
              body.sub(block.first, "#{block.first} |#{params}|")
            else
              body
            end
          end

          def extract_params
            tokens = self.tokens

            if tokens[1].lparen?
              i_rparen = tokens.rindex(&:rparen?)
              t_evts = tokens[(i_rparen-2) ... i_rparen].map(&:evt)

              if t_evts == [:nl, :sp]
                tokens[i_rparen-2].frag = "\\\n"
              elsif t_evts[-1] == :nl
                tokens[i_rparen-1].frag = "\\\n"
              end

              tokens[2 ... i_rparen].map {|t| t.frag(block.indent) }.join
            end
          end

        end
      end
    end
  end
end
