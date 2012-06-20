Sourcify.require_rb('common', 'parser', 'raw_scanner', 'extensions')

module Sourcify
  module Method
    class Parser
      module RawScanner #:nodoc:all
        module Extensions

          include Common::Parser::RawScanner::Extensions
          Counter = Common::Parser::RawScanner::Counter

          def increment_lineno
            stop_if_probably_defined_by_proc
            super
          end

          def stop_if_probably_defined_by_proc
            raise ProbablyDefinedByProc if @lineno == 1 && @results.empty? && !@counter.started?
          end

          def increment_counter(count = 1)
            unless @counter.started?
              return if (@rejecting_block = codified_tokens !~ @start_pattern)
              offset_attributes
            end
            @counter.increment(count)
          end

          def decrement_counter
            @counter.decrement
            construct_result_code if @counter.balanced?
          end

          def construct_result_code
            codes = [false, true].map do |fix_heredoc|
              code = codified_tokens(fix_heredoc)
              code.force_encoding(@encoding) if @encoding
              code
            end

            begin
              if valid?(codes[1]) && @body_matcher.call(codes[0])
                # NOTE: Need to fix singleton method to avoid errors (eg. undefined object)
                # downstream
                @results << codes.map do |s|
                  s.sub(%r{^(def\s+)(?:[^\.]+\.)?(#{@name}.*end)$}m, '\1\2')
                end
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

          def valid?(*args)
            # TODO: shouldn't need this check, there seems to be a bug w raw_scanner.rl.
            args[0].start_with?('def') && super
          end

        end
      end
    end
  end
end
