module Sourcify
  module Common
    class Parser
      module RawScanner #:nodoc:all
        class Heredoc < Struct.new(:tag, :indented, :encoding)

          def <<(content)
            (@contents ||= []) << content
          end

          def to_s
            content = @contents.join.split("\n")[1..-2].join.
              gsub(/\\|'/) {|c| "\\#{c}" }
            content.force_encoding(encoding) if encoding
            %('#{content}')
          end

          def closed?(sealer)
            return false unless sealer == "\n"
            parts = @contents[-1].split("\n")
            return true if parts[-1] == tag
            indented && parts[-1].sub(/^\s*(.*)$/,'\1') == tag
          end

        end
      end
    end
  end
end
