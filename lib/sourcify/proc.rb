module Sourcify

  class MultipleMatchingProcsPerLineError < Exception; end
  class NoMatchingProcError < Exception; end
  class ParserInternalError < Exception; end
  class CannotParseEvalCodeError < Exception; end
  class CannotHandleCreatedOnTheFlyProcError < Exception; end

  module Proc
    def self.included(base)
      base.class_eval do
        Sourcify.require_rb('proc', 'methods')
        include Methods::SourceLocation
        include Methods::ToSource
        include Methods::ToSexp
      end
    end
  end

end

Proc.class_eval do
  include Sourcify::Proc
end
