module Sourcify
  module Proc
    module Extractor
      module Block
        class Base

          def initialize(type, frag)
            @encoding, @type, @frags = frag.encoding, type, [frag]
          end

          def dubious?
            false
          end

          def lambda_op?
            false
          end

          def invalid?
            false
          end

          def <<(frag)
            @frags << frag
          end

          def params
            instance_eval(body).parameters
          end

        protected

          def encode(string)
            string.force_encoding(@encoding)
          end

          def correct?(string)
            !!sexp(string)
          end

          def sexp(string)
            Ripper.sexp(string) rescue nil
          end

        end
      end
    end
  end
end
