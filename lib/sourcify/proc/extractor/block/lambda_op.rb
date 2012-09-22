module Sourcify
  module Proc
    module Extractor
      module Block
        class LambdaOp < Base

          attr_reader :block
          always_true :lambda_op?

          def initialize(*args)
            @block = nil
            super
          end

          def <<(token)
            if @block
              @block << token
            else
              case token.evt
              when :tlambeg
                @block = Brace.new(type, token)
              when :kw_do
                @block = DoEnd.new(type, token)
              else
                super
              end
            end
          end

          def done?
            @done ||=
              if @block && @block.done?
                !!(@body = body)
              end
          end

          def body(style = :raw)
            case style
            when :raw
              @body || encode(%(#{tokens}#{@block.tokens}))
            when :indented
              finalize(combined_tokens)
            when :stripped
              @block.body(:stripped)
            else
              raise ArgumentError
            end
          end

        private

          def combined_tokens
            block_ts, params_ts = block.tokens, fixed_tokens
            return block_ts.indented unless params_ts[1].lparen?

            Tokens.new([
              block_ts[0],
              Token.new(nil, :sp, ' '),
              Token.new(nil, :op, '|'),
              params_ts[2 ... params_ts.rindex(&:rparen?)],
              Token.new(nil, :op, '|'),
              block_ts[1 .. -1]
            ].flatten).indented
          end

          def fixed_tokens
            ts = tokens
            return ts unless ts[1].lparen?

            i_rparen = ts.rindex(&:rparen?)
            t_evts = ts[(i_rparen-2) ... i_rparen].map(&:evt)

            if t_evts == [:nl, :sp]
              ts[i_rparen-2].frag = "\\\n"
            elsif t_evts[-1] == :nl
              ts[i_rparen-1].frag = "\\\n"
            end

            ts
          end

        end
      end
    end
  end
end
