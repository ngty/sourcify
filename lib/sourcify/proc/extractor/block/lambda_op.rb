module Sourcify
  module Proc
    module Extractor
      module Block
        class LambdaOp < Base

          def initialize(*args)
            @block = nil
            super
          end

          def <<(token)
            if @block
              @block << token
            else
              case token[EVT]
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
            indent = @block.indent

            params =
              if tokens[1][EVT] == :lparen
                i_rparen = tokens.rindex{|t| t[EVT] == :rparen }
                t_evts = tokens[(i_rparen-2) ... i_rparen].map{|t| t[EVT] }

                if t_evts == [:nl, :sp]
                  tokens[i_rparen-2][FRG] = "\\\n"
                elsif t_evts[-1] == :nl
                  tokens[i_rparen-1][FRG] = "\\\n"
                end

                tokens[2 ... i_rparen].map {|t| t[FRG].sub(indent,'') }.join
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
