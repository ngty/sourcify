module Sourcify
  module Proc
    class Source

      attr_reader :metadata

      def initialize(file, line)
        extracted = Extractor.process(file, :line => line)
        @metadata = Metadata.new(
          file,
          extracted[:sexp],
          extracted[:positions][:from],
          extracted[:positions][:till]
        )
      end

      def raw
        RawSource.new(metadata)
      end

      def to_s
        Sorcerer.source(metadata.sexp)
      end

    private

      Metadata = Class.new(Struct.new(:file, :sexp, :from_pos, :till_pos))

    end
  end
end
