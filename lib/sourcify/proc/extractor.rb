require 'ripper'
require 'forwardable'

module Sourcify
  module Proc
    class Extractor < Ripper::SexpBuilder

      Result = Struct.new(:src)
      Constraints = Struct.new(:params, :lambda, :line)

      class << self
        def process(block)
          file, line = block.source_location
          constraints = Constraints.new(block.parameters, block.lambda?, line)
          new(::File.read(file)).process(constraints)
        end
      end

      def process(constraints)
        @blocks, @constraints = Blocks.new(constraints.lambda), constraints
        catch(:done) { parse }

        results = @blocks.map do |b|
          b.body if b.params == @constraints.params
        end.compact

        raise MultipleMatchingProcsPerLineError if results.size > 1
        raise NoMatchingProcError if results.empty?

        Result.new(results.first)
      end

      def on_tlambda(*args)
        super(*args).tap do |_,frag,_|
          break if lineno < @constraints.line
          @blocks.append(frag).create(frag)
        end
      end

      def on_kw(*args)
        super(*args).tap do |_,frag,_|
          break if lineno < @constraints.line

          case frag
          when "do"
            if lineno == @constraints.line
              @blocks.append(frag).create(frag)
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

      def on_lbrace(*args)
        super(*args).tap do |_,frag,_|
          break if lineno < @constraints.line

          if lineno == @constraints.line
            @blocks.append(frag).create(frag)
          else
            @blocks.append(frag)
          end
        end
      end

      def on_rbrace(*args)
        super(*args).tap do |_,frag,_|
          break if lineno < @constraints.line
          @blocks.append!(frag)
        end
      end

      (SCANNER_EVENTS - [:kw, :lbrace, :rbrace, :tlambda]).each do |event|
        define_method(:"on_#{event}") do |args|
          super(*args).tap do |_,frag,_|
            break if lineno < @constraints.line
            @blocks.append(frag)
          end
        end
      end

    private

      class Blocks
        include Enumerable
        extend Forwardable

        def_delegators :@blocks, :each

        def initialize(is_lambda)
          @type, @blocks = is_lambda ? 'lambda' : 'proc', []
        end

        def create(*args)
          @blocks << Single.new(@type, *args)
        end

        def append(frag)
          tap do
            map{|b| b << frag unless b.done? }
          end
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

          def initialize(type, frag)
            @type, @frags = type, [frag]
          end

          def <<(frag)
            @frags << frag
          end

          def done?
            @done ||=
              %w(} end).include?(@frags[-1]) &&
                !!(Ripper.sexp(%(#{body})) rescue nil)
          end

          def body
            "#{@type} " +
              case @frags[0]
              when '->'
                case @frags[1]
                when '('
                  i_paren, i_do, i_brace = %w") do {".map{|s| @frags.index(s) }

                  if i_do && (i_brace.nil? || i_do < i_brace)
                     %(do |#{@frags[2...i_paren]*''}|#{@frags[(i_do+1)..-1]*''})
                  else
                     %({ |#{@frags[2...i_paren]*''}|#{@frags[(i_brace)..-1]*''})
                  end
                else
                  @frags[1..-1]*''
                end
              else
                @frags*''
              end
          end

          def params
            instance_eval(body).parameters
          end

        end

      end

    end
  end
end
