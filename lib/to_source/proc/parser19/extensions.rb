module ToSource
  module Proc
    class Parser19
      module Extensions
        module Result

          def same_as_curr_line
            same_line(curr_line)
          end

          def curr_line
            curr[0][0]
          end

          def curr
            self[-1]
          end

          def same_line(line)
            (
              reverse.take_while do |e|
                (e[0][0] == line) or (e[0][-1] == "\\\n" && line -= 1; true)
              end
            ).extend(Extensions::Result)
          end

          def keywords(*types)
            (
              types = [types].flatten
              select{|e| e[1] == :on_kw && types.include?(e[-1]) }
            ).extend(Extensions::Result)
          end

          def non_spaces(*types)
            (
              types = [types].flatten
              reject{|e| e[1] == :on_sp }
            ).extend(Extensions::Result)
          end

        end
      end
    end
  end
end
