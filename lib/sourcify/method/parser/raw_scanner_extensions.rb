Sourcify.require_rb('common', 'scanner', 'extensions')

module Sourcify
  module Method
    class Parser
      module RawScanner #:nodoc:all
        module Extensions

          include Common::Scanner::Extensions
          class Counter < Common::Scanner::Counter; end

          def increment_counter(count = 1)
            unless @counter.started?
              return if (@rejecting_block = codified_tokens !~ @start_pattern)
              offset_attributes
            end
            @counter.increment(count)
          end

          def decrement_counter
            return unless @counter.started?
            @counter.decrement
            construct_result_code if @counter.balanced?
          end

          def construct_result_code
            code = codified_tokens.strip

            begin
              if valid?(code) && @body_matcher.call(code)
                @results << code
                raise Escape if @stop_on_newline or @lineno != 1
                reset_attributes
              end
            rescue Exception
              raise if $!.is_a?(Escape)
            end
          end

          def reset_attributes
            @counter = Counter.new
            super
          end

        end
      end
    end
  end
end
