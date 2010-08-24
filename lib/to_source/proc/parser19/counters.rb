module ToSource
  module Proc
    class Parser19
      module Counters

        class Base

          attr_accessor :marker

          def initialize
            @marker, @counter = nil, {:start => 0, :end => 0}
          end

          def [](key)
            @counter[key]
          end

          def started?
            @counter.values != [0,0]
          end

          def telly?
            @counter[:start] == @counter[:end]
          end

          def decrement_start
            @counter[:start] -= 1
            self
          end

          def increment_start
            @counter[:start] += 1
            self
          end

          def increment_end
            @counter[:end] += 1
            self
          end

        end

        class DoEndBlock  < Base ; end
        class BracedBlock < Base ; end

      end

    end
  end
end

