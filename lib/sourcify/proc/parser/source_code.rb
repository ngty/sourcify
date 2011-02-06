module Sourcify
  module Proc
    class Parser #:nodoc:all
      class SourceCode < Struct.new(:file, :line)

        def line
          super.pred
        end

        def to_s
          case file
          when /\(irb\)/ then from_irb_to_s
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

      end
    end
  end
end
