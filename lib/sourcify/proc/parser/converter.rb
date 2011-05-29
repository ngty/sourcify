module Sourcify
  module Proc
    class Parser #:nodoc:all
      Sourcify.require_rb('common', 'parser', 'converter')
      Converter = Common::Parser::Converter
    end
  end
end
