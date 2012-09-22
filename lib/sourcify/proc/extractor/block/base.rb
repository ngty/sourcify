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

          attr_reader :type

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
            Source.new(body(:indented), body(:stripped))
          end

          def body(style = :raw)
            case style
            when :raw
              @body || finalize(block)
            when :indented
              finalize(tokens.indented)
            when :stripped
              encode(tokens.stripped.indented)
            else
              raise ArgumentError
            end
          end

          def tokens
            @tokens.sorted
          end

        protected

          def finalize(thing)
            thing && encode("#{@type} #{thing}")
          end

          def encode(thing)
            thing.to_s.force_encoding(@encoding)
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
