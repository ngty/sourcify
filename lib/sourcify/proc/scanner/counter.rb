module Sourcify
  module Proc
    module Scanner #:nodoc:all
      class Counter

        attr_reader :counts

        def initialize
          @counts = [0,0]
        end

        def started?
          @counts.any?(&:nonzero?)
        end

        def just_started?
          @counts.any?{|count| count == 1 }
        end

        def balanced?
          @counts.any?(&:zero?)
        end

        def decrement
          (0..1).each{|i| @counts[i] -= 1 unless @counts[i].zero? }
        end

        def increment(val = 1)
          if val.is_a?(Range)
            @counts[0] += val.first
            @counts[1] += val.last
          else
            (0..1).each{|i| @counts[i] += 1 }
          end
        end

      end

      class DoEndBlockCounter < Counter; end
      class BraceBlockCounter < Counter; end

    end
  end
end
