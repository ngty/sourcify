%w{heredoc comment dstring counter}.each do |f|
  Sourcify.require_rb('proc', 'scanner', f)
end

module Sourcify
  module Proc
    module Scanner #:nodoc:all
      module Extensions

        class Escape < Exception; end
        RUBY_PARSER = RubyParser.new

        def process(data, opts={})
          begin
            @start_pattern = opts[:start_pattern] || /.*/
            @body_matcher = opts[:body_matcher] || lambda{|_| true }
            @stop_on_newline = opts[:stop_on_newline]
            @results, @data = [], data.unpack("c*")
            reset_attributes
            execute!
          rescue Escape
            @results
          end
        end

        def data_frag(range)
          @data[range].pack('c*')
        end

        def push(key, ts, te)
          @tokens << [key, data_frag(ts .. te.pred)]
        end

        def push_dstring(ts, te)
          data = data_frag(ts .. te.pred)
          @dstring ||= DString.new(data[%r{^("|`|/|%(?:Q|W|r|x|)(?:\W|_))},1])
          @dstring << data
          return true unless @dstring.closed?
          @tokens << [:dstring, @dstring.to_s]
          @dstring = nil
        end

        def push_comment(ts, te)
          data = data_frag(ts .. te.pred)
          @comment ||= Comment.new
          @comment << data
          return true unless @comment.closed?
          @tokens << [:comment, @comment.to_s]
          @comment = nil
        end

        def push_heredoc(ts, te)
          data = data_frag(ts .. te.pred)
          unless @heredoc
            indented, tag = data.match(/\<\<(\-?)['"]?(\w+)['"]?$/)[1..3]
            @heredoc = Heredoc.new(tag, !indented.empty?)
          end
          @heredoc << data
          return true unless @heredoc.closed?(data_frag(te .. te))
          @tokens << [:heredoc, @heredoc.to_s]
          @heredoc = nil
        end

        def push_label(ts, te)
          # NOTE: 1.9.* supports label key, which RubyParser cannot handle, thus
          # conversion is needed.
          data = data_frag(ts .. te.pred)
          @tokens << [:symbol, data.sub(/^(.*)\:$/, ':\1')]
          @tokens << [:space, ' ']
          @tokens << [:assoc, '=>']
        end

        def preceded_with?(*args)
          begin
            prev_token = @tokens[-1][0] == :space ? @tokens[-2] : @tokens[-1]
            !([args].flatten & prev_token).empty?
          rescue
          end
        end

        def increment_lineno
          @lineno += 1
          if @stop_on_newline || !@results.empty? || (@results.empty? && @rejecting_block)
            raise Escape
          end
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

        def fix_counter_false_start(key)
          return unless this_counter(key).just_started?
          return unless really_false_started?
          reset_attributes
          @tokens, @false_start_backup = @false_start_backup.dup, nil if @false_start_backup
        end

        def other_counter(type)
          {:do_end => @brace_counter, :brace => @do_end_counter}[type]
        end

        def this_counter(type)
          {:brace => @brace_counter, :do_end => @do_end_counter}[type]
        end

        def construct_result_code
          code = <<-SOURCIFIED_HEREDOKIE.strip
            proc #{codified_tokens}
          SOURCIFIED_HEREDOKIE

          begin
            if safe_eval(code) && @body_matcher.call(code)
              @results << code
              raise Escape if @stop_on_newline or @lineno != 1
              reset_attributes
            end
          rescue Exception
            raise if $!.is_a?(Escape)
          end
        end

        def codified_tokens
          @tokens.map(&:last).join
        end

        def reset_attributes
          @tokens = []
          @lineno = 1
          @heredoc, @dstring, @comment = nil
          @do_end_counter = DoEndBlockCounter.new
          @brace_counter = BraceBlockCounter.new
          @rejecting_block = false
        end

        def really_false_started?
          safe_eval(<<-SOURCIFIED_HEREDOKIE.strip
              #{codified_tokens} 1}
            SOURCIFIED_HEREDOKIE
          ) && true
        end

        def offset_attributes
          @lineno = 1 # Fixing JRuby's lineno bug (see http://jira.codehaus.org/browse/JRUBY-5014)
          unless @tokens.empty?
            last = @tokens[-1]
            @tokens.clear
            @tokens << last
          end
        end

        def safe_eval(string)
          Parser::Converter.to_sexp(string)
        end

      end
    end
  end
end
