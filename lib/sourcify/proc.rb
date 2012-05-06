require 'ripper'

Sourcify.require_rb(%w{
  proc/sexp_util
  proc/extractor
  proc/source
})

module Sourcify
  module Proc

    def to_source
      Source.new
    end

  end
end
