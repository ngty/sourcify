Sourcify.require_rb(%w{
  proc/extractor/sexper
})

module Sourcify
  module Proc
    module Extractor
      class << self
        def process(block)
          file, line = block.source_location
          conditions = {:params => block.parameters, :line => line}

          Sexper.new(::File.read(file)).extract(conditions)
        end
      end
    end
  end
end
