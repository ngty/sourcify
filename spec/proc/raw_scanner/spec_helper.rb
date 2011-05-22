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

module Sourcify::Proc::Parser::RawScanner

  SCANNER = self

  module Spec
    module Setup
      def self.extended(base)
        base.instance_eval do

          before do
            Extensions::DoEndBlockCounter.class_eval do
              alias_method :orig_started?, :started?
              def started?; true; end
            end
          end

          after do
            Extensions::DoEndBlockCounter.class_eval do
              alias_method :started?, :orig_started?
            end
          end

          def kw_block_start_counter(data)
            SCANNER.process(data)
            SCANNER.do_end_counter.counts
          end

          def kw_block_start_alias1
            %w{class def module begin case module if unless}
          end

          def kw_block_start_alias2
            %w{while until for}
          end

        end
      end
    end
  end
end
