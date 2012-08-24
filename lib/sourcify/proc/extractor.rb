require 'ripper'
require 'sorcerer'

module Sourcify
  module Proc
    class Extractor < Ripper::SexpBuilder

      Result = Struct.new(:src)

      class << self
        def process(block)
          file, line = block.source_location
          conditions = {:params => block.parameters, :line => line}

          new(::File.read(file)).process(conditions)
        end
      end

      def process(conditions)
        @blocks = []
        @conditions = conditions
        @constraints = Constraints.new(conditions)
        @positions, @sexps = [], []

        catch(:done) { parse }
        raise MultipleMatchingProcsPerLineError if @blocks.size > 1
        Result.new(@blocks.first.body)
      end

      SCANNER_EVENTS.each do |event|
        case event
        when :kw

          def on_kw(*args)
            super(*args).tap do |expr|
              frag, pos = expr[1..2]

              case frag
              when "do"
                if pos[0] == @conditions[:line]
                  @blocks << Block.new(:do_end, frag, pos)
                else
                  @blocks.each{|b| b << frag unless b.done? }
                end
              when "end"
                @blocks.each{|b| b << frag unless b.done? }
                throw :done if @blocks.first && @blocks.map(&:done?).all?
              else
                @blocks.each{|b| b << frag unless b.done? }
              end
            end
          end

        when :lbrace

          def on_lbrace(*args)
            super(*args).tap do |expr|
              frag, pos = expr[1..2]

              if pos[0] == @conditions[:line]
                @blocks << Block.new(:brace, frag, pos)
              else
                @blocks.each{|b| b << frag unless b.done? }
              end
            end
          end

        when :on_rbrace

          def on_rbrace(*args)
            super(*args).tap do |expr|
              frag, pos = expr[1..2]

              @blocks.each{|b| b << frag unless b.done? }
              throw :done if @blocks.first && @blocks.map(&:done?).all?
            end
          end

        else

          define_method(:"on_#{event}") do |args|
            super(*args).tap do |expr|
              break if @blocks.empty?
              @blocks.each{|b| b << expr[1] unless b.done? }
            end
          end

        end
      end

      # def on_method_add_block(*args)
      #   super(*args).tap do |expr|
      #     if @constraints.match?(expr)
      #       @sexps << extract_sexp(expr)
      #     end
      #   end
      # end

    private

      def extract_sexp(sexp)
        sexp
      end

      class Block

        attr_reader :type

        def initialize(type, frag, pos)
          @type, @pos, @frags = type, pos, [frag]
        end

        def <<(frag)
          @frags << frag
        end

        def done?
          @done ||=
            !!(Ripper.sexp(%(#{body})) rescue nil)
        end

        def body
          %(proc #{@frags.join})
        end

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
