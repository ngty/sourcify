module ToSource
  module Proc
    class Parser19
      module Extensions
        module Result

          POS, TYP, VAL = 0, 1, 2
          ROW, COL= 0, 1

          def same_as_curr_line
            same_line(curr_line)
          end

          def curr_line
            curr[POS][ROW]
          end

          def curr
            self[-1]
          end

          def same_line(line)
            (
              # ignore the current node
              self[0..-2].reverse.take_while do |e|
                if e[TYP] == :on_semicolon && e[VAL] == ';'
                  false
                elsif e[POS][ROW] == line
                  true
                elsif e[TYP] == :on_sp && e[VAL] == "\\\n"
                  line -= 1
                  true
                end
              end.reverse
            ).extend(Extensions::Result)
          end

          def keywords(*types)
            (
              types = [types].flatten.map(&:to_s)
              select{|e| e[TYP] == :on_kw && (types.empty? or types.include?(e[VAL])) }
            ).extend(Extensions::Result)
          end

          def non_spaces(*types)
            (
              types = [types].flatten
              reject{|e| e[TYP] == :on_sp && (types.empty? or types.include?(e[VAL])) }
            ).extend(Extensions::Result)
          end

          def start_of_line?
            same_as_curr_line.non_spaces.empty?
          end

          def within_block?
            same_as_curr_line.non_spaces[-1][TYP] == :on_lparen
          end

          def stringify(marker)
            self[index(marker) .. -1].map do |e|
              e[TYP] == :on_label ? (':%s => ' % e[VAL][0..-2]) : e[VAL]
            end.join
          end

        end
      end
    end
  end
end
