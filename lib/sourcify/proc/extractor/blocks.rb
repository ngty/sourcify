require 'forwardable'
Sourcify.require_rb('proc/extractor/block')

module Sourcify
  module Proc
    module Extractor
      class Blocks

        include Enumerable
        extend Forwardable

        def_delegators :@blocks, :each, :empty?

        def initialize(is_lambda)
          @type, @blocks = is_lambda ? 'lambda' : 'proc', []
        end

        def create(frag)
          tap { @blocks << Block.new(@type, frag) }
        end

        def append(frag)
          tap { map{|b| b << frag unless b.done? } }
        end

        def done?
          first && all?(&:done?)
        end

        def compact!
          @blocks.each_index do |i|
            next unless prev = @blocks[i.pred]
            next unless prev.lambda_op? && prev.block.do_end?

            @blocks[i] = nil if prev.block == @blocks[i]
          end.compact!

          @blocks.reject!(&:invalid?)
        end

      end
    end
  end
end
