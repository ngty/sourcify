module Sourcify
  module Proc
    class Source

      attr_reader :metadata

      def initialize(file, line)
        conditions = {:line => line}

        # TODO: Need to revise SexpUtil to make the following more
        # efficient
        positions = SexpUtil.new(File.read(file)).locate(conditions)
        sexp = SexpUtil.new(File.read(file)).extract(conditions)

        @metadata = Metadata.new(file, sexp, positions[:from], positions[:till])
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
