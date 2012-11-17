Sourcify.require_rb(
  'proc/extractor/lexer',
  'proc/match'
)

module Sourcify
  module Proc
    module Extractor

      Constraints = Struct.new(:params, :line, :is_lambda, :matcher) do
        alias_method :lambda?, :is_lambda

        def match?(nth, total, block)
          return true unless matcher
          matcher.call(Match.new(nth, total, block))
        end
      end

      class << self
        def process(block, &matcher)
          file = File.new(block)

          constraints = Constraints.new(
            block.parameters, file.line, block.lambda?, matcher
          )

          offset_constraints =
            if constraints.is_lambda
              lambda { constraints.line = constraints.line.pred }
            else
              lambda { constraints.line = constraints.line.next }
            end

          file.open do |io|
            until extracted = catch(:retry) { Lexer.process(io, constraints) }
              io.rewind; offset_constraints.call
            end

            extracted
          end
        end
      end

    end
  end
end
