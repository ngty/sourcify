Sourcify.require_rb(%w{
  proc/extractor
  proc/source
  proc/raw_source
})

module Sourcify
  module Proc

    def to_source
      Source.new(*source_location)
    end

  end
end
