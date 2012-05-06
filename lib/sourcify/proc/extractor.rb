Sourcify.require_rb(%w{
  proc/extractor/sexper
})

module Sourcify
  module Proc
    module Extractor
      class << self
        def process(file, conditions)
          Sexper.new(::File.read(file)).extract(conditions)
        end
      end
    end
  end
end
