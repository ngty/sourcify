require 'ripper'
require 'forwardable'

module Sourcify
  module Proc
    class Extractor < Ripper::SexpBuilder

      Result = Struct.new(:src)
      Constraints = Struct.new(:params, :line)

      class << self
        def process(block)
          file, line = block.source_location
          constraints = Constraints.new(block.parameters, line)
          new(::File.read(file)).process(constraints)
        end
      end

      def process(constraints)
        @blocks, @constraints = Blocks.new, constraints
        catch(:done) { parse }

        results = @blocks.map do |b|
          b.body if b.params == @constraints.params
        end.compact

        raise MultipleMatchingProcsPerLineError if results.size > 1
        Result.new(results.first)
      end

      SCANNER_EVENTS.each do |event|
        case event
        when :kw

          def on_kw(*args)
            super(*args).tap do |expr|
              frag, pos = expr[1..2]
              break if pos[0] < @constraints.line

              case frag
              when "do"
                if pos[0] == @constraints.line
                  @blocks.append(frag)
                  @blocks.create(:do_end, frag, pos)
                else
                  @blocks.append(frag)
                end
              when "end"
                @blocks.append!(frag)
              else
                @blocks.append(frag)
              end
            end
          end

        when :lbrace

          def on_lbrace(*args)
            super(*args).tap do |expr|
              frag, pos = expr[1..2]
              break if pos[0] < @constraints.line

              if pos[0] == @constraints.line
                @blocks.append(frag)
                @blocks.create(:brace, frag, pos)
              else
                @blocks.append(frag)
              end
            end
          end

        when :on_rbrace

          def on_rbrace(*args)
            super(*args).tap do |expr|
              frag, pos = expr[1..2]
              break if pos[0] < @constraints.line

              @blocks.append!(frag)
            end
          end

        else

          define_method(:"on_#{event}") do |args|
            super(*args).tap do |expr|
              frag, pos = expr[1..2]
              break if pos[0] < @constraints.line

              @blocks.append(frag)
            end
          end

        end
      end


    private

      class Blocks
        include Enumerable
        extend Forwardable

        def_delegators :@blocks, :each

        def initialize
          @blocks = []
        end

        def create(*args)
          @blocks << Single.new(*args)
        end

        def append(frag)
          map{|b| b << frag unless b.done? }
        end

        def append!(frag)
          flags = map do |b|
            b << frag unless b.done?
            b.done?
          end

          throw :done if flags.first && flags.all?
        end

      private

        class Single

          def initialize(type, frag, pos)
            @type, @frags, @pos = type, [frag], pos
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

          def params
            instance_eval(body).parameters
          end

        end

      end

    end
  end
end
