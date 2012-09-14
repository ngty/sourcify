module Sourcify
  module Proc
    module Extractor
      module Block
        class Base

          POS = 0
          EVT = 1
          FRG = 2

          def initialize(type, token)
            @encoding, @type, @tokens = token[FRG].encoding, type, [token]
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

          def indented_body
            ts = self.tokens

            if ts[-2][EVT] == :sp && (ts[-3][EVT] == :nl || ts[-3][FRG][-1].end_with?("\n"))
              indent = ts[-2][FRG]
              frags = []

              ts.each_with_index do |t, i|
                next unless ts[i.pred]

                if t[EVT] == :heredoc_end
                  frags << t[FRG].sub(indent,'')
                elsif (_t = ts[i.succ]) && _t[EVT] == :sp && (t[EVT] == :nl || t[FRG].end_with?("\n"))
                  frags << t[FRG] << _t[FRG].sub(indent,'')
                elsif t[EVT] == :sp && ((_t = ts[i.pred])[EVT] == :nl || _t[FRG].end_with?("\n"))
                  # do nothing
                else
                  frags << t[FRG]
                end
              end

              finalize(' ' + frags.join)
            else
              body
            end
          end

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
