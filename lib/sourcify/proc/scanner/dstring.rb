module Sourcify
  module Proc
    module Scanner #:nodoc:all
      class DString < Struct.new(:tag)

        def <<(content)
          (@contents ||= []) << content
        end

        def to_s
          @contents.join
        end

        def closed?
          # NOTE: The only real error is SyntaxError, other errors are due
          # to undefined variable or watever, which are perfectly ok when
          # testing for validity of the string.
          begin
            instance_eval(safe_contents) if evaluable?
          rescue SyntaxError
            false
          rescue Exception
            true
          end
        end

        private

          CLOSING_TAGS = {'(' => ')', '[' => ']', '<' => '>', '{' => '}'}

          def evaluable?
            @contents[-1][-1].chr == end_tag
          end

          def safe_contents
            # NOTE: %x & ` strings are dangerous to eval cos they execute shell commands,
            # thus we convert them to normal strings 1st
            @contents.join.gsub(/(%x)(\W|\_)/, '%Q\2').gsub(/.{0,2}(`)/) do |s|
              s =~ /^(%Q|%W|%r|%x|.?%|.?\\)/ ? s : s.sub(/`$/,'%Q`')
            end
          end

          def start_tag
            @start_tag ||= tag[-1].chr
          end

          def end_tag
            @end_tag ||= (CLOSING_TAGS[start_tag] || start_tag)
          end

      end
    end
  end
end
