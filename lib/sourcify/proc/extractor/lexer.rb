require 'ripper'
Sourcify.require_rb('proc/extractor/blocks')

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

          results = @blocks.map do |b|
            b.body if b.params == @constraints.params && !b.dubious?
          end.compact

          if results.empty? && @constraints.params.empty?
            results = @blocks.select(&:dubious?)[-1..-1].map(&:body)
          end

          case results.size
          when 0
            if @constraints.lambda?
              throw :retry, nil
            else
              raise NoMatchingProcError
            end
          when 1
            results.first
          else
            raise MultipleMatchingProcsPerLineError
          end
        end

        def on_tlambda(frag)
          return unless processable?
          token = [pos, :tlambda, frag]
          @blocks.append(token).create(token)
        end

        def on_kw(frag)
          return unless processable?
          token = [pos, :"#{frag}", frag]

          case frag
          when 'do'
            if lineno == @constraints.line
              @blocks.append(token).create(token)
            else
              @blocks.append(token)
            end
          when 'end'
            @blocks.append(token)
          else
            @blocks.append(token)
          end
        end

        [:tlambeg, :lbrace].each do |event|
          define_method(:"on_#{event}") do |frag|
            return unless processable?
            token = [pos, :"#{event}", frag]

            if lineno == @constraints.line
              @blocks.append(token).create(token)
            else
              @blocks.append(token)
            end
          end
        end

        (SCANNER_EVENTS - [:kw, :tlambeg, :lbrace, :tlambda]).each do |event|
          define_method(:"on_#{event}") do |frag|
            return unless processable?
            token = [pos, :"#{event}", frag]
            @blocks.append(token)
          end
        end

      private

        def processable?
          if lineno > @constraints.line && @blocks.done?
            throw :done
          end

          case lineno <=> @constraints.line
          when -1 then false
          when 0 then true
          else !@blocks.empty? or throw(:retry, nil)
          end
        end

        def pos
          [lineno, column]
        end

      end
    end
  end
end
