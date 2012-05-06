require 'ripper'

module Sourcify
  module Proc
    module Extractor
      class Sexper < Ripper::SexpBuilder

        def extract(conditions)
          @constraints = Constraints.new(conditions)
          @positions, @sexps = [], []
          parse

          # TODO: Need to handle case when we have multiple matches
          {:sexp => @sexps.first, :positions => @positions.first}
        end

        def on_method_add_block(*args)
          super(*args).tap do |expr|
            if @constraints.match?(expr)
              @positions << extract_positions(expr)
              @sexps << extract_sexp(expr)
            end
          end
        end

      private

        def extract_sexp(sexp)
          sexp
        end

        def extract_positions(sexp)
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
              case @sexp[1][0]
              when :method_add_arg then @sexp[1][1][1][-1][0]
              when :call then @sexp[1][-1][-1][0]
              else 0
              end
          end
        end

      end
    end
  end
end
