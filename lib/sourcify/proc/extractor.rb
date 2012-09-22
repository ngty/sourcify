Sourcify.require_rb('proc/extractor/lexer')

module Sourcify
  module Proc
    module Extractor

      Constraints = Struct.new(:params, :line, :is_lambda) do
        alias_method :lambda?, :is_lambda
      end

      class << self
        def process(block)
          file = File.new(block)
          constraints = Constraints.new(block.parameters, file.line, block.lambda?)

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
