module Sourcify
  module Proc
    module File
      class << self

        def chunk(file, from, till)
          lines = ::File.readlines(file)[from[0].pred .. till[0].pred]
          [
            lines[0][from[1].pred .. -1],
            lines[1..-2],
            lines[-1][0 .. till[1].pred]
          ].flatten.compact * ""
        end

      end
    end
  end
end
