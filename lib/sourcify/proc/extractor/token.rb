module Sourcify
  module Proc
    module Extractor
      class Token < Struct.new(:pos, :evt, :frag)

        def nl?
          evt == :nl
        end

        def sp?
          evt == :sp
        end

        def heredoc_end?
          evt == :heredoc_end
        end

        def lparen?
          evt == :lparen
        end

        def rparen?
          evt == :rparen
        end

        def end_with_nl?
          frag.end_with?("\n")
        end

        def frag(indent = nil)
          indent ? super().sub(indent,'') : super()
        end

      end
    end
  end
end
