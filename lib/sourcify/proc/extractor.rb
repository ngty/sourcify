require 'ripper'
require 'stringio'
require 'forwardable'

module Sourcify
  module Proc
    class Extractor < Ripper::SexpBuilder

      Result = Struct.new(:src)
      Constraints = Struct.new(:params, :line, :is_lambda)

      class << self
        def process(block)
          file, line = block.source_location
          constraints = Constraints.new(block.parameters, line, block.lambda?)

          offset_constraints =
            if constraints.is_lambda
              lambda { constraints.line = constraints.line.pred }
            else
              lambda { constraints.line = constraints.line.next }
            end

          StringIO.open(::File.read(file)) do |io|
            until result = catch(:retry) { new(io).process(constraints) }
              io.rewind; offset_constraints.call
            end

            result
          end
        end
      end

      def process(constraints)
        @blocks, @constraints = Blocks.new(constraints.is_lambda), constraints
        catch(:done) { parse }

        results = @blocks.map do |b|
          b.body if b.params == @constraints.params
        end.compact

        case results.size
        when 0
          if @constraints.is_lambda
            throw :retry, nil
          else
            raise NoMatchingProcError
          end
        when 1
          Result.new(results.first)
        else
          raise MultipleMatchingProcsPerLineError
        end
      end

      def on_tlambda(*args)
        super(*args).tap do |_,frag,_|
          retry_if_skewed! or break
          @blocks.append(frag).create(frag)
        end
      end

      def on_kw(*args)
        super(*args).tap do |_,frag,_|
          retry_if_skewed! or break

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
          retry_if_skewed! or break
          @blocks.append!(frag)
        end
      end

      [:tlambeg, :lbrace].each do |event|
        define_method(:"on_#{event}") do |args|
          super(*args).tap do |_,frag,_|
            retry_if_skewed! or break

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
            retry_if_skewed! or break
            @blocks.append(frag)
          end
        end
      end

    private

      def retry_if_skewed!
        case lineno <=> @constraints.line
        when -1 then false
        when 0 then true
        else !@blocks.empty? || throw(:retry, nil)
        end
      end

      class Blocks
        include Enumerable
        extend Forwardable

        def_delegators :@blocks, :each, :empty?

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
            @type + (lambda_op? ? lambda_op_body : %( #{@frags*''}))
          end

          def params
            instance_eval(body).parameters
          end

        private

          def lambda_op_body
            case @frags[1]
            when '('
              frags = @frags.dup
              i_rparen, i_do, i_lbrace = %w") do {".map{|s| frags.index(s) }
              i_nl = frags[0..i_rparen].rindex("\n")
              frags[i_nl] = "\\" + frags[i_nl] if i_nl

              if i_do && (i_lbrace.nil? || i_do < i_lbrace)
                 %( do |#{frags[2...i_rparen]*''}|#{frags[(i_do+1)..-1]*''})
              else
                 %( { |#{frags[2...i_rparen]*''}|#{frags[(i_lbrace+1)..-1]*''})
              end
            when / +/
              %(#{@frags[1..-1]*''})
            else
              %( #{@frags[1..-1]*''})
            end
          end

        end

      end

    end
  end
end
