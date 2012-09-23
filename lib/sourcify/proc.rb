Sourcify.require_rb(%w{proc/extractor})

module Sourcify

  class MultipleMatchingProcsPerLineError < Exception; end
  class NoMatchingProcError < Exception; end

  module Proc

    def to_source
      Extractor.process(self)
    end

  end
end
