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

              ts.each_with_index do |t_curr, i|
                next unless ts[i.pred]

                if t_curr.heredoc_end?
                  frags << t_curr.frag(indent)
                elsif (t_next = ts[i.succ]) && t_next.sp? && (t_curr.nl? || t_curr.end_with_nl?)
                  frags << t_curr.frag << t_next.frag(indent)
                elsif t_curr.sp? && ((t_next = ts[i.pred]).nl? || t_next.end_with_nl?)
                  # do nothing
                else
                  frags << t_curr.frag
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
