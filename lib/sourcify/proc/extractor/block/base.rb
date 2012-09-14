module Sourcify
  module Proc
    module Extractor
      module Block
        class Base

          def initialize(type, token)
            @encoding, @type, @tokens = token[-1].encoding, type, [token]
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

          def <<(token)
            @tokens << token
          end

          def params
            instance_eval(body).parameters
          end

        protected

          def tokens
            @tokens.sort_by{|pos, *_| pos }
          end

          def frags
            tokens.map(&:last)
          end

          def finalize(string)
            string && (@type + string).force_encoding(@encoding)
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
