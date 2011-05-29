module Sourcify
  module Proc
    class Parser #:nodoc:all
      Sourcify.require_rb('common', 'parser', 'source_code')
      SourceCode = Common::Parser::SourceCode
    end
  end
end
