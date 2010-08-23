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
              # ignore the current node
              self[0..-2].reverse.take_while do |e|
                if e[1] == :on_semicolon && e[-1] == ';'
                  false
                elsif e[0][0] == line
                  true
                elsif e[1] == :on_sp && e[-1] == "\\\n"
                  line -= 1
                  true
                end
              end
            ).extend(Extensions::Result)
          end

          def keywords(*types)
            (
              types = [types].flatten
              select{|e| e[1] == :on_kw && (types.empty? or types.include?(e[-1])) }
            ).extend(Extensions::Result)
          end

          def non_spaces(*types)
            (
              types = [types].flatten
              reject{|e| e[1] == :on_sp && (types.empty? or types.include?(e[-1])) }
            ).extend(Extensions::Result)
          end

        end
      end
    end
  end
end
