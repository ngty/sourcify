require 'forwardable'

Sourcify.require_rb(
  'proc/extractor/block',
  'proc/extractor/lambda_op_block',
  'proc/extractor/brace_block',
  'proc/extractor/do_end_block'
)

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
          tap do
            @blocks <<
              case frag
              when 'do' then DoEndBlock.new(@type, frag)
              when '{'  then BraceBlock.new(@type, frag)
              when '->' then LambdaOpBlock.new(@type, frag)
              else raise ArgumentError
              end
          end
        end

        def append(frag)
          tap do
            map{|b| b << frag unless b.done? }
          end
        end

        def done?
          first && all?(&:done?)
        end

        def compact!
          @blocks.each_index do |i|
            next if i.zero?
            prev = @blocks[i.pred]
            @blocks[i] = nil if prev && prev.lambda_op?
          end.compact!

          @blocks.reject!(&:invalid?)
        end

      end
    end
  end
end
