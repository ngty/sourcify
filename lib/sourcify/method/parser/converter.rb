module Sourcify
  module Method
    class Parser #:nodoc:all
      Sourcify.require_rb('common', 'parser', 'converter')
      Converter = Common::Parser::Converter
    end
  end
end
