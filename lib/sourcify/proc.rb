Sourcify.require_rb(%w{
  proc/extractor
  proc/source
  proc/raw_source
})

module Sourcify
  module Proc

    def to_source
      Source.new(self)
    end

  end
end
