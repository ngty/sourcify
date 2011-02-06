module Sourcify
  module Proc
    class Parser #:nodoc:all
      class Converter
        class << self

          RUBY_PARSER = RubyParser.new
          RUBY_2_RUBY = Ruby2Ruby.new

          def to_sexp(code, file = nil)
            retried = false
            begin
              RUBY_PARSER.reset
              (retried ? RubyParser.new : RUBY_PARSER).parse(*[code, file].compact)
            rescue Racc::ParseError, SyntaxError
              return nil if retried
              retried = true; retry
            end
          end

          def to_code(sexp)
            RUBY_2_RUBY.process(Sexp.from_array(sexp.to_a))
          end

        end
      end
    end
  end
end
