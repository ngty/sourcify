module Sourcify
  module Extensions
    module File

      def chunk(from, till)
        start_line, start_col = from
        end_line, end_col = till

        readlines[start_line.pred ... end_line].tap do |lines|
          lines[0].slice!(0 ... start_col)
          lines[-1].slice!(end_col .. -1)
        end * ''
      end

    end
  end
end
