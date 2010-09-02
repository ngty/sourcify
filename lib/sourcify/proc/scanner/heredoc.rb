module Sourcify
  module Proc
    module Scanner #:nodoc:all
      class Heredoc < Struct.new(:tag, :indented)

        def <<(content)
          (@contents ||= []) << content
        end

        def to_s
          @contents.join
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
