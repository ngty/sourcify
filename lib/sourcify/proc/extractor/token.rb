module Sourcify
  module Proc
    module Extractor
      class Token < Struct.new(:pos, :evt, :frag)

        def nl?
          [:nl, :ignored_nl].include?(evt)
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

        def op?
          evt == :op
        end

        def end_with_nl?
          frag.end_with?("\n")
        end

        def trim(indent)
          Token.new(pos, evt, frag.sub(indent,''))
        end

      end
    end
  end
end
