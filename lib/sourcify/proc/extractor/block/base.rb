module Sourcify
  module Proc
    module Extractor
      module Block
        class Base

          attr_reader :body

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
            @params ||= instance_eval(body).parameters
          end

          def ==(other)
            body == other.body
          end

          def done?
            @done ||=
              if frags.last == last && correct?(raw_body)
                !!(@body = indented_body)
              end
          end

          def stripped_body
            ts = strip_params(self.tokens[1 ... -1])

            # Trim appending sp & nl
            if i = ts.rindex{|t| !t.sp? && !t.nl? }
              ts.slice!(i.succ .. -1)
            end

            # Trim prepending sp & nl
            if i = ts.index{|t| !t.sp? && !t.nl? }
              if (t_prev = ts[i.pred]) && t_prev.sp?
                ts.slice!(0 ... i.pred)
              else
                ts.slice!(0 ... i)
              end
            end

            encode(apply_indent(ts))
          end

        protected

          def raw_body
            finalize(block)
          end

          def indented_body
            finalize(' ' + apply_indent(self.tokens))
          end

          def strip_params(ts)
            count = 0

            ts.each_with_index do |t, i|
              case count
              when 2
                return ts[i..-1]
              when 1
                count += 1 if t.op?
              else
                if t.op?
                  count = 1
                elsif !t.nl? && !t.sp?
                  return ts[i..-1]
                end
              end
            end
          end

          def apply_indent(ts)
            if ts.index(&:nl?).nil? or not \
               ts[-2].sp? && (ts[-3].nl? || ts[-3].end_with_nl?)
              return ts.map(&:frag).join.strip
            end

            @indent = ts[-2].frag # NOTE: unintended side-effect, potential bug !!
            frags = []

            ts.each_with_index do |t_curr, i|
              next unless ts[i.pred]

              if t_curr.heredoc_end?
                frags << t_curr.frag(@indent)
              elsif (t_next = ts[i.succ]) && t_next.sp? && (t_curr.nl? || t_curr.end_with_nl?)
                frags << t_curr.frag << t_next.frag(@indent)
              elsif t_curr.sp? && ((t_next = ts[i.pred]).nl? || t_next.end_with_nl?)
                # do nothing
              else
                frags << t_curr.frag
              end
            end

            frags.join.strip
          end

          def tokens
            @tokens.sort_by(&:pos)
          end

          def frags
            tokens.map(&:frag)
          end

          def finalize(string)
            string && encode("#{@type} #{string.strip}")
          end

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
