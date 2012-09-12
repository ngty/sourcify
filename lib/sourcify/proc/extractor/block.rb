Sourcify.require_rb(
  'proc/extractor/block/base',
  'proc/extractor/block/lambda_op',
  'proc/extractor/block/brace',
  'proc/extractor/block/do_end'
)

module Sourcify
  module Proc
    module Extractor
      module Block

        def self.new(type, frag)
          case frag
          when 'do' then DoEnd.new(type, frag)
          when '{'  then Brace.new(type, frag)
          when '->' then LambdaOp.new(type, frag)
          else raise ArgumentError
          end
        end

      end
    end
  end
end
