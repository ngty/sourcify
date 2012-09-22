require 'forwardable'
Sourcify.require_rb('proc/extractor/token')

module Sourcify
  module Proc
    module Extractor
      class Tokens

        extend Forwardable
        def_delegators :@tokens, :map, :<<, :last, :[], :rindex

        def initialize(tokens = [])
          @tokens = tokens
        end

        def end_with?(frag)
          last.frag == frag
        end

        def sorted
          Tokens.new(@tokens.sort_by(&:pos))
        end

        def stripped
          count, ts = 0, @tokens[1..-1]

          # Trim params (if any)
          ts.each_with_index do |t, i|
            case count
            when 2
              ts.slice!(0 ... i)
              break
            when 1
              count += 1 if t.op?
            else
              if t.op?
                count = 1
              elsif !t.nl? && !t.sp?
                ts.slice!(0 ... i)
                break
              end
            end
          end

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

          Tokens.new(ts)
        end

        def indented
          ts = @tokens.dup

          if ts.index(&:nl?).nil? or not \
             ts[-2].sp? && (ts[-3].nl? || ts[-3].end_with_nl?)
            return self
          end

          indent = ts[-2].frag # NOTE: Can this be a bug ??
          tokens = Tokens.new

          ts.each_with_index do |t_curr, i|
            next unless ts[i.pred]

            if t_curr.heredoc_end?
              tokens << t_curr.trim(indent)
            elsif (t_next = ts[i.succ]) && t_next.sp? && (t_curr.nl? || t_curr.end_with_nl?)
              tokens << t_curr << t_next.trim(indent)
            elsif t_curr.sp? && ((t_next = ts[i.pred]).nl? || t_next.end_with_nl?)
              # do nothing
            else
              tokens << t_curr
            end
          end

          tokens
        end

        def to_s
          map(&:frag).join.strip
        end

      end
    end
  end
end
