%w{heredoc comment dstring counter}.each do |f|
  Sourcify.require_rb('common', 'parser', 'raw_scanner', f)
end

module Sourcify
  module Common
    class Parser
      module RawScanner #:nodoc:all
        module Extensions

          class Escape < Exception; end

          def process(data, opts={})
            begin
              @encoding = data.encoding if ''.respond_to?(:force_encoding)
              @start_pattern = opts[:start_pattern] || /.*/
              @body_matcher = opts[:body_matcher] || lambda{|_| true }
              @stop_on_newline = opts[:stop_on_newline]
              @results, @data = [], data.unpack("c*")
              reset_attributes
              execute!
            rescue Escape
              return @results unless @encoding
              @results.map{|result| result.force_encoding(@encoding) }
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
            @dstring ||= DString.new(data[%r{^("|`|/|%(?:Q|W|r|x|)(?:\W|_))},1], @encoding)
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
            @tokens << [:symbol, ':' + data_frag(ts .. te - 2)]
            @tokens << [:space, ' ']
            @tokens << [:assoc, '=>']
          end

          def preceded_with?(*args)
            prev_token = @tokens[-1][0] == :space ? @tokens[-2] : @tokens[-1]
            !([args].flatten & prev_token).empty? rescue nil
          end

          def increment_lineno
            @lineno += 1
            raise Escape \
              if @stop_on_newline || !@results.empty? || (@results.empty? && @rejecting_block)
          end

          def codified_tokens
            @tokens.map(&:last).join
          end

          def reset_attributes
            @tokens, @lineno = [], 1
            @heredoc, @dstring, @comment, @rejecting_block = nil
          end

          def offset_attributes
            @lineno = 1 # Fixing JRuby's lineno bug (see http://jira.codehaus.org/browse/JRUBY-5014)
            @tokens = [@tokens[-1]] unless @tokens.empty?
          end

          if HAS_RIPPER

            def valid?(snippet, validate_as = nil)
              sexp = Ripper.sexp(snippet)

              case validate_as
              when :hash then sexp[-1][0][0] == :hash
              when nil then sexp && true
              else raise ArgumentError
              end
            end

          else

            def valid?(snippet, _ = nil)
              RubyParser.new.parse("#{snippet}") rescue false
            end

          end

        end
      end
    end
  end
end
