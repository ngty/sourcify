module Sourcify
  module Method
    class Parser #:nodoc:all
      Sourcify.require_rb('common', 'parser', 'source_code')
      SourceCode = Common::Parser::SourceCode
    end
  end
end
