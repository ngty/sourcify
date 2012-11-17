require 'ripper'
Sourcify.require_rb(
  'proc/extractor/blocks',
  'proc/extractor/tokens'
)

module Sourcify
  module Proc
    module Extractor
      class Lexer < Ripper::Lexer

        def self.process(io, constraints)
          new(io).process(constraints)
        end

        def process(constraints)
          @blocks, @constraints = Blocks.new(constraints.lambda?), constraints
          catch(:done) { parse }

          @blocks.compact!

          # Grab only procs w matching parameters
          results = @blocks.select do |b|
            b.params == @constraints.params && !b.dubious?
          end.compact

          # OOPS, empty results .. let's cater for cases where
          # the procs look like an empty hash (the dubious scenario)
          if results.empty? && @constraints.params.empty?
            results = @blocks.select(&:dubious?)[-1..-1]
          end

          # Last pass, make sure we satisfy custom matcher specified
          results.each_with_index do |block, nth|
            next if constraints.match?(nth, results.size, block)
            results[nth] = nil
          end.compact!

          case results.size
          when 0
            if @constraints.lambda?
              throw :retry, nil
            else
              raise NoMatchingProcError
            end
          when 1
            results.first.to_source
          else
            raise MultipleMatchingProcsPerLineError
          end
        end

        def on_tlambda(frag)
          return unless processable?
          token = Token.new(pos, :tlambda, frag)
          @blocks.append_create(token)
        end

        def on_kw(frag)
          return unless processable?
          token = Token.new(pos, :"kw_#{frag}", frag)

          case frag
          when 'do'
            if lineno == @constraints.line
              @blocks.append_create(token)
            else
              @blocks.append(token)
            end
          when 'end'
            @blocks.append(token)
          else
            @blocks.append(token)
          end
        end

        def on_lbrace(frag)
          return unless processable?
          token = Token.new(pos, :lbrace, frag)

          if lineno == @constraints.line
            @blocks.append_create(token)
          else
            @blocks.append(token)
          end
        end

        (SCANNER_EVENTS - [:kw, :lbrace, :tlambda]).each do |event|
          define_method(:"on_#{event}") do |frag|
            return unless processable?
            token = Token.new(pos, :"#{event}", frag)
            @blocks.append(token)
          end
        end

      private

        def processable?
          case lineno <=> @constraints.line
          when -1 then false
          when 0 then true
          else
            if @blocks.empty?
              throw :retry, nil
            elsif @blocks.done?
              throw :done
            else
              true
            end
          end
        end

        def pos
          [lineno, column]
        end

      end
    end
  end
end
