module Sourcify
  module Proc
    module Extractor
      module Block
        class Brace < Base

          always_true :brace?

          def invalid?
            !!@invalid
          end

          def dubious?
            !!@dubious
          end

          def first
            '{'
          end

          def last
            '}'
          end

          def done?
            if invalid?
              true
            else
              @done ||= super
            end
          end

        private

          def block
            block = %( #{tokens})
            expr = sexp(block)

            if expr && expr[1] && (e = expr[1][0])[0] == :hash
              if e[1].nil?
                @dubious = true
              else
                @invalid = true
                return
              end
            end

            block
          end

        end
      end
    end
  end
end
