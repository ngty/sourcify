module Sourcify

  class MultipleMatchingProcsPerLineError < Exception ; end
  class ParserInternalError < Exception ; end

  module Proc

    def self.included(base)
      base.class_eval do

        meths = instance_methods.map(&:to_s)

        # Added as a bonus, by default, only 1.9.* implements this.
        unless meths.include?('source_location')
          def source_location
            @source_location ||= (
              file, line = /^#<Proc:0x[0-9A-Fa-f]+@(.+):(\d+).*?>$/.match(inspect)[1..2]
              [file, line.to_i]
            )
          end
        end

        if Object.const_defined?(:ParseTree)
          # When ParseTree is available, we just make use of all the convenience it offers :)
          alias_method :to_source, :to_ruby

        else
          # Otherwise, we are going to do abit of static text parsing :(

          unless meths.include?('to_source')
            def to_source
              Sourcify.require_rb('proc', 'parser')
              (@parser ||= Parser.new(self)).source
            end
          end

          unless meths.include?('to_sexp')
            def to_sexp
              Sourcify.require_rb('proc', 'parser')
              (@parser ||= Parser.new(self)).sexp
            end
          end

        end
      end
    end

  end
end

::Proc.class_eval do
  include Sourcify::Proc
end
