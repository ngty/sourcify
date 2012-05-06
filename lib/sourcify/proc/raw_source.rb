module Sourcify
  module Proc
    class RawSource

      attr_reader :metadata

      def initialize(metadata)
        @metadata = metadata
      end

      def to_s
        File.open(metadata.file, 'r') do |fh|
          fh.extend(Extensions::File)
          normalize_indents(fh.chunk(metadata.from_pos, metadata.till_pos))
        end
      end

    private

      def normalize_indents(code)
        indent = code.split("\n")[-1].match(/^\s+/)
        code.gsub("\n#{indent}","\n")
      end

    end
  end
end
