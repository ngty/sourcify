module Sourcify
  module Proc
    module Extractor
      module Block
        class Base

          def initialize(type, token)
            @encoding, @type, @tokens = token.frag.encoding, type, [token]
          end

          def dubious?
            false
          end

          def lambda_op?
            false
          end

          def do_end?
            false
          end

          def brace?
            false
          end

          def indent
            @indent || ''
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

            if ts[-2].sp? && (ts[-3].nl? || ts[-3].end_with_nl?)
              @indent = ts[-2].frag
              frags = []

              ts.each_with_index do |t, i|
                next unless ts[i.pred]

                if t.heredoc_end?
                  frags << t.frag(indent)
                elsif (_t = ts[i.succ]) && _t.sp? && (t.nl? || t.end_with_nl?)
                  frags << t.frag << _t.frag(indent)
                elsif t.sp? && ((_t = ts[i.pred]).nl? || _t.end_with_nl?)
                  # do nothing
                else
                  frags << t.frag
                end
              end

              finalize(' ' + frags.join)
            else
              body
            end
          end

          def tokens
            @tokens.sort_by(&:pos)
          end

          def frags
            tokens.map(&:frag)
          end

          def finalize(string)
            string && ("#{@type} #{string.strip}").force_encoding(@encoding)
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
