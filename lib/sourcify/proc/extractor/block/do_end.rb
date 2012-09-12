module Sourcify
  module Proc
    module Extractor
      module Block
        class DoEnd < Base

          def done?
            @done ||=
              if @frags[-1] == 'end' && correct?(s = body)
                !!(@body = s)
              end
          end

          def body
            @body || encode(%(#{@type} #{@frags*''}))
          end

        end
      end
    end
  end
end
