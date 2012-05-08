require 'forwardable'

module Sourcify
  module Proc
    class Source
      extend Forwardable

      attr_reader :metadata
      def_delegators :metadata, *[:object, :file, :sexp, :start_pos, :end_pos]

      def initialize(block)
        file, line = block.source_location
        extracted = Extractor.process(file, :line => line)

        @metadata = Metadata.new(
          block,
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

      Metadata = Struct.new(:object, :file, :sexp, :start_pos, :end_pos)

    end
  end
end
