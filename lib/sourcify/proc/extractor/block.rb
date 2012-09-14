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

        def self.new(type, token)
          case token[-1]
          when 'do' then DoEnd.new(type, token)
          when '{'  then Brace.new(type, token)
          when '->' then LambdaOp.new(type, token)
          else raise ArgumentError
          end
        end

      end
    end
  end
end
