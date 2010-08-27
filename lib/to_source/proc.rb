module ToSource
  module Proc

    def self.included(base)
      base.class_eval do
        if Object.const_defined?(:ParseTree)
          # When ParseTree is available, we just make use of all the convenience it offers :)
          alias_method :to_source, :to_ruby
        else
          # Otherwise, we are going to do abit of static text parsing :(
          meths = instance_methods.map(&:to_s)

          unless meths.include?('to_source')
            def to_source
              require 'to_source/proc/parser'
              (@parser ||= Parser.new(self)).source
            end
          end

          unless meths.include?('to_sexp')
            def to_sexp
              require 'to_source/proc/parser'
              (@parser ||= Parser.new(self)).sexp
            end
          end

          unless meths.include?('source_location')
            def source_location
              @source_location ||= (
                file, line = /^#<Proc:0x[0-9A-Fa-f]+@(.+):(\d+).*?>$/.match(inspect)[1..2]
                [file, line.to_i]
              )
            end
          end

        end
      end
    end

  end
end

::Proc.class_eval do
  include ToSource::Proc
end
