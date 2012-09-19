module Sourcify
  module Proc
    module Extractor
      module Block
        class DoEnd < Base

          def do_end?
            true
          end

          def first
            'do'
          end

          def last
            'end'
          end

        private

          def block
            frags.join
          end

        end
      end
    end
  end
end
