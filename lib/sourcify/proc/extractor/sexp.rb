require 'ripper'
Sourcify.require_rb('proc/extractor/blocks')

module Sourcify
  module Proc
    module Extractor
      class Sexp < Ripper::SexpBuilder

        def self.process(io, constraints)
          new(io).process(constraints)
        end

        def process(constraints)
          @blocks, @constraints = Blocks.new(constraints.is_lambda), constraints
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

        def on_tlambda(*args)
          super(*args).tap do |_,frag,_|
            break unless processable?
            @blocks.append(frag).create(frag)
          end
        end

        def on_kw(*args)
          super(*args).tap do |_,frag,_|
            break unless processable?

            case frag
            when "do"
              if lineno == @constraints.line
                @blocks.append(frag).create(frag)
              else
                @blocks.append(frag)
              end
            when "end"
              @blocks.append(frag)
            else
              @blocks.append(frag)
            end
          end
        end

        def on_rbrace(*args)
          super(*args).tap do |_,frag,_|
            break unless processable?
            @blocks.append(frag)
            @blocks.done? if lineno > @constraints.line
          end
        end

        [:tlambeg, :lbrace].each do |event|
          define_method(:"on_#{event}") do |args|
            super(*args).tap do |_,frag,_|
              break unless processable?

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
              break unless processable?
              @blocks.append(frag)
            end
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

      end
    end
  end
end
