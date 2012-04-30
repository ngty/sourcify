module Sourcify
  module Proc
    class SexpUtil < Ripper::SexpBuilder

      def locate(constraints)
        @mode, @constraints = :locate, Constraints.new(constraints)
        parse
      end

      def extract(constraints)
        @mode, @constraints = :extract, Constraints.new(constraints)
        parse
      end

      def on_method_add_block(*args)
        super(*args).tap do |x|
          @extracted << send(:"perform_#{@mode}", x) if @constraints.match?(args)
        end
      end

    private

      def parse
        @extracted = []
        super
        @extracted.first
      end

      def perform_extract(sexp)
        sexp
      end

      def perform_locate(sexp)
        pos =
          case sexp[1][0]
          when :method_add_arg then sexp[1][1][1][-1]
          when :call then sexp[1][1][-1][-1]
          else raise ArgumentError
          end

        {
          :from => pos,
          :till => [lineno, column]
        }
      end

    private

      class Constraints

        def initialize(conditions)
          @conditions = conditions
        end

        def match?(sexp)
          @sexp = sexp
          match_line?
        end

      private

        def match_line?
          @conditions[:line] ==
            case @sexp[0][0]
            when :method_add_arg then @sexp[0][1][1][-1][0]
            when :call then @sexp[0][-1][-1][0]
            else 0
            end
        end
      end

    end
  end
end
