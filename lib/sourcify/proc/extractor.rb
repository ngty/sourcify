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

        case results.size
        when 0 then raise NoMatchingProcError
        when 1 then Result.new(results.first)
        else raise MultipleMatchingProcsPerLineError
        end
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

      def on_rbrace(*args)
        super(*args).tap do |_,frag,_|
          break if lineno < @constraints.line
          @blocks.append!(frag)
        end
      end

      [:tlambeg, :lbrace].each do |event|
        define_method(:"on_#{event}") do |args|
          super(*args).tap do |_,frag,_|
            break if lineno < @constraints.line

            if lineno == @constraints.line
              @blocks.append(frag).create(frag)
            else
              @blocks.append(frag)
            end
          end
        end
      end

      (SCANNER_EVENTS - [:kw, :tlambeg, :lbrace, :rbrace, :tlambda]).each do |event|
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

          if flags.first && flags.all?
            trash_duplicates!
            throw :done
          end
        end

      private

        def trash_duplicates!
          @blocks.each_index do |i|
            next if i.zero?
            prev = @blocks[i.pred]
            @blocks[i] = nil if prev && prev.lambda_op?
          end.compact!
        end

        class Single

          def initialize(type, frag)
            @type, @frags = type, [frag]
          end

          def lambda_op?
            @is_lambda_op ||= @frags[0] == '->'
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
            case @frags[0]
            when '->'
              case @frags[1]
              when '('
                i_paren, i_do, i_brace = %w") do {".map{|s| @frags.index(s) }

                if i_do && (i_brace.nil? || i_do < i_brace)
                   %(#{@type} do |#{@frags[2...i_paren]*''}|#{@frags[(i_do+1)..-1]*''})
                else
                   %(#{@type} { |#{@frags[2...i_paren]*''}|#{@frags[(i_brace+1)..-1]*''})
                end
              when / +/
                %(#{@type}#{@frags[1..-1]*''})
              else
                %(#{@type} #{@frags[1..-1]*''})
              end
            else
              %(#{@type} #{@frags*''})
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
