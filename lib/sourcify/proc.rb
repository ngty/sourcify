module Sourcify

  class MultipleMatchingProcsPerLineError < Exception ; end

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

        # When ParseTree is available, we just make use of all the convenience it offers :)
        if Object.const_defined?(:ParseTree)

          alias_method :to_source, :to_ruby

        # Otherwise, we are going to do abit of static text parsing :(
        else

          unless meths.include?('to_source')
            def to_source
              require 'sourcify/proc/parser'
              (@parser ||= Parser.new(self)).source
            end
          end

          unless meths.include?('to_sexp')
            def to_sexp
              require 'sourcify/proc/parser'
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
