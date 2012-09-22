module Sourcify
  module Proc
    module Extractor
      module Block
        class DoEnd < Base

          always_true :do_end?

          def first
            'do'
          end

          def last
            'end'
          end

        private

          def block
            tokens.to_s
          end

        end
      end
    end
  end
end
