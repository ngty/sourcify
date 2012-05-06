require 'ripper'

Sourcify.require_rb(%w{
  proc/sexp_util
  proc/extractor
  proc/source
  proc/raw_source
})

module Sourcify
  module Proc

    def to_source
      Source.new
    end

  end
end
