Sourcify.require_rb('common', 'scanner', 'extensions')

module Sourcify
  module Proc
    module Scanner #:nodoc:all
      module Extensions

        include Common::Scanner::Extensions
        class DoEndBlockCounter < Common::Scanner::Counter; end
        class BraceBlockCounter < Common::Scanner::Counter; end

        def fix_counter_false_start(key)
          return unless this_counter(key).just_started?
          return unless really_false_started?
          reset_attributes
          @tokens, @false_start_backup = @false_start_backup.dup, nil if @false_start_backup
        end

        def increment_counter(key, count = 1)
          return if other_counter(key).started?
          unless (counter = this_counter(key)).started?
            return if (@rejecting_block = codified_tokens !~ @start_pattern)
            @false_start_backup = @tokens.dup if key == :brace
            offset_attributes
          end
          counter.increment(count)
        end

        def decrement_counter(key)
          return unless (counter = this_counter(key)).started?
          counter.decrement
          construct_result_code if counter.balanced?
        end

        def other_counter(type)
          {:do_end => @brace_counter, :brace => @do_end_counter}[type]
        end

        def this_counter(type)
          {:brace => @brace_counter, :do_end => @do_end_counter}[type]
        end

        def construct_result_code
          code = %Q(proc #{codified_tokens}).strip

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

        def really_false_started?
          valid?(%Q(#{codified_tokens} 1}))
        end

        def reset_attributes
          @do_end_counter = DoEndBlockCounter.new
          @brace_counter = BraceBlockCounter.new
          super
        end

      end
    end
  end
end
