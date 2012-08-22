require 'ripper'
require 'sorcerer'

module Sourcify
  module Proc
    class Extractor < Ripper::SexpBuilder

      Result = Struct.new(:sexp)

      class << self
        def process(block)
          file, line = block.source_location
          conditions = {:params => block.parameters, :line => line}

          new(::File.read(file)).process(conditions)
        end
      end

      def process(conditions)
        @constraints = Constraints.new(conditions)
        @positions, @sexps = [], []
        parse

        raise MultipleMatchingProcsPerLineError if @sexps.size > 1
        Result.new(@sexps.first)
      end

      def on_method_add_block(*args)
        super(*args).tap do |expr|
          if @constraints.match?(expr)
            @sexps << extract_sexp(expr)
          end
        end
      end

    private

      def extract_sexp(sexp)
        sexp
      end

      class Constraints

        def initialize(conditions)
          @conditions = conditions
        end

        def match?(sexp)
          @sexp = sexp
          match_line? && match_params?
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

        def match_params?
          @conditions[:params] ==
            instance_eval("proc " + Sorcerer.source(@sexp[-1])).parameters
        end

      end

    end
  end
end
