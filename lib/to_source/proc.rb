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
              require 'to_source/proc/parser19'
              (@parser ||= Parser19.new(self)).source
            end
          end

          unless meths.include?('to_sexp')
            def to_sexp
              require 'to_source/proc/parser19'
              (@parser ||= Parser19.new(self)).sexp
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
