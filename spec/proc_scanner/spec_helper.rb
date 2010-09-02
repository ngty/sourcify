curr_dir = File.dirname(File.expand_path(__FILE__))
require File.join(curr_dir, '..', 'spec_helper')

ragel_dir = File.join(curr_dir, '..', '..', 'lib', 'sourcify', 'proc')
ragel_file = File.join(ragel_dir, 'scanner.rl')
ruby_file = File.join(ragel_dir, 'scanner.rb')
File.delete(ruby_file) rescue nil
system("ragel -R #{ragel_file}")

begin
  require File.join(ragel_dir, 'scanner.rb')
rescue LoadError
  raise $!
end

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
