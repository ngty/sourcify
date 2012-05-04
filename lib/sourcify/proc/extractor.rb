module Sourcify
  module Proc
    module Extractor
      class << self

        def extract_source(block)
          file, line = block.source_location
          sexp = SexpUtil.new(File.read(file)).extract(:line => line)
          Sorcerer.source(sexp)
        end

      end
    end
  end
end
