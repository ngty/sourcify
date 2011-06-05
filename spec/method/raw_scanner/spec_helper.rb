require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../../../raw_scanner/shared_specs', __FILE__)

module Sourcify::Method::Parser::RawScanner

  SCANNER = self

  class << self
    attr_reader :tokens, :counter
  end

  module Spec

    module GenericSupport
      def self.extended(base)
        base.instance_eval do

          before do
            SCANNER.instance_eval do
              class << self
                alias_method :orig_stop_if_probably_defined_by_proc,
                  :stop_if_probably_defined_by_proc
                def stop_if_probably_defined_by_proc; end
              end
            end
          end

          after do
            SCANNER.instance_eval do
              class << self
                alias_method :stop_if_probably_defined_by_proc,
                  :orig_stop_if_probably_defined_by_proc
              end
            end
          end

          def process(data)
            SCANNER.process(data)
            SCANNER.tokens
          end

        end
      end
    end

    module KwBlockStartSupport
      def self.extended(base)
        base.instance_eval do

          before do
            Extensions::Counter.class_eval do
              alias_method :orig_started?, :started?
              def started?; true; end
            end
          end

          after do
            Extensions::Counter.class_eval do
              alias_method :started?, :orig_started?
            end
          end

          def kw_block_start_counter(data)
            SCANNER.process(data)
            SCANNER.counter.counts
          end

          def kw_block_start_alias1
            %w{class do module begin case module if unless}
          end

          def kw_block_start_alias2
            %w{while until for}
          end
        end
      end
    end

  end
end
