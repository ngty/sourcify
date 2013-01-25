module Sourcify
  module Common
    class Parser #:nodoc:all
      class SourceCode < Struct.new(:file, :line)

        def line
          p ['LINE', super, super.pred]
          super.pred
        end

        def to_s
          case file
          when /\(irb\)/, /\(irb\#\d+\)/ then from_irb_to_s
          when /\(pry\)/ then from_pry_to_s
          else from_file_to_s
          end
        end

        def from_file_to_s
          File.open(file, 'r') do |fh|
            fh.extend(File::Tail).forward(line)
            fh.readlines.join
          end
        end

        def from_irb_to_s
          # Really owe it to Florian Groß's solution @ http://rubyquiz.com/quiz38.html ...
          # anyway, note that we use *line.succ* instead of *line* here.
          IRB.CurrentContext.io.line(line.succ .. -1).join
        end

        def from_pry_to_s
          start = Pry.history.session_line_count
          history = Pry.history.to_a[-start .. -1]
          lines = history[line .. -1] * "\n"

          #p ['DEBUG', start, line, history, history[line], history[line .. -1]]
          lines
        end

      end
    end
  end
end
