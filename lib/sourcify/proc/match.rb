module Sourcify
  module Proc
    class Match < Struct.new(:index, :total, :block)

      private :total, :block

      def body
        @body ||= block.to_source.strip.to_s
      end

      def first?
        index.zero?
      end

      def last?
        index.succ == total
      end

    end
  end
end
