require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper')

module Sourcify::Proc::Scanner
  class << self ; attr_reader :tokens ; end
  class << self ; attr_reader :do_end_counter ; end
end

def process(data)
  Sourcify::Proc::Scanner.process(data)
  Sourcify::Proc::Scanner.tokens
end

def do_end_counter(data)
  Sourcify::Proc::Scanner.process(data)
  Sourcify::Proc::Scanner.do_end_counter.counts
end

shared 'has started do...end counter' do

  before do
    Sourcify::Proc::Scanner::DoEndBlockCounter.class_eval do
      alias_method :orig_started?, :started?
      def started?; true; end
    end
  end

  after do
    Sourcify::Proc::Scanner::DoEndBlockCounter.class_eval do
      alias_method :started?, :orig_started?
    end
  end

end
