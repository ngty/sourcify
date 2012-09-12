module Sourcify
  module Proc
    module Extractor
      module Block
        class LambdaOp < Base

          def lambda_op?
            true
          end

          def done?
            @done ||=
              if %w(} end).include?(@frags[-1]) && correct?(s = body)
                !!(@body = s)
              end
          end

          def body
            @body || encode(@type + block)
          end

        private

          def block
            case @frags[1]
            when '('
              frags = @frags.dup
              i_rparen, i_do, i_lbrace = %w") do {".map{|s| frags.index(s) }
              i_nl = frags[0..i_rparen].rindex("\n")
              frags[i_nl] = "\\" + frags[i_nl] if i_nl

              if i_do && (i_lbrace.nil? || i_do < i_lbrace)
                 %( do |#{frags[2...i_rparen]*''}|#{frags[(i_do+1)..-1]*''})
              else
                 %( { |#{frags[2...i_rparen]*''}|#{frags[(i_lbrace+1)..-1]*''})
              end
            when / +/
              %(#{@frags[1..-1]*''})
            else
              %( #{@frags[1..-1]*''})
            end
          end

        end
      end
    end
  end
end
