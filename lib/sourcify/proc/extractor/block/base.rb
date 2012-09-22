require 'forwardable'

Sourcify.require_rb(
  'proc/extractor/tokens',
  'proc/extractor/block/always'
)

module Sourcify
  module Proc
    module Extractor
      module Block
        class Base

          extend Forwardable
          def_delegators :@tokens, :<<

          extend Block::Always
          always_false :dubious?, :lambda_op?, :do_end?, :brace?, :invalid?

          def initialize(type, token)
            @encoding, @type = token.frag.encoding, type
            @tokens = Tokens.new([token])
          end

          def params
            @params ||= instance_eval(body).parameters
          end

          def ==(other)
            body == other.body
          end

          def done?
            @done ||=
              if @tokens.end_with?(last) && completed?(s = body)
                !!(@body = s)
              end
          end

          def to_source
            Source.new(
              finalize(@tokens.indent),
              finalize(@tokens.strip.indent)
            )
          end

          def body
            @body ||
              begin
                finalize(block)
              end
          end

        protected

          def tokens
            @tokens.sort!
            @tokens
          end

          def finalize(thing)
            thing && encode("#{@type} #{thing.to_s.strip}")
          end

          def encode(string)
            string.force_encoding(@encoding)
          end

          def completed?(string)
            !!sexp(string)
          end

          def sexp(string)
            Ripper.sexp(string) rescue nil
          end

        end
      end
    end
  end
end
