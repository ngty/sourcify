module Sourcify
  module Proc
    module Extractor
      module Block
        class DoEnd < Base

          def do_end?
            true
          end

          def done?
            @done ||=
              if frags[-1] == 'end' && correct?(body)
                !!(@body = indented_body)
              end
          end

          def body
            @body || finalize(%(#{frags*''}))
          end

        end
      end
    end
  end
end
