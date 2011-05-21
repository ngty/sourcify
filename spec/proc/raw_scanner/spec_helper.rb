require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../../../raw_scanner/shared_specs', __FILE__)

module Sourcify::Proc::Parser::RawScanner
  class << self ; attr_reader :tokens ; end
  class << self ; attr_reader :do_end_counter ; end
end

def process(data)
  Sourcify::Proc::Parser::RawScanner.process(data)
  Sourcify::Proc::Parser::RawScanner.tokens
end

def do_end_counter(data)
  Sourcify::Proc::Parser::RawScanner.process(data)
  Sourcify::Proc::Parser::RawScanner.do_end_counter.counts
end

shared 'has started do...end counter' do

  before do
    Sourcify::Proc::Parser::RawScanner::Extensions::DoEndBlockCounter.class_eval do
      alias_method :orig_started?, :started?
      def started?; true; end
    end
  end

  after do
    Sourcify::Proc::Parser::RawScanner::Extensions::DoEndBlockCounter.class_eval do
      alias_method :started?, :orig_started?
    end
  end

end
