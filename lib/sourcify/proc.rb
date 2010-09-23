module Sourcify

  class MultipleMatchingProcsPerLineError < Exception; end
  class ParserInternalError < Exception; end
  class CannotParseEvalCodeError < Exception; end
  class CannotHandleCreatedOnTheFlyProcError < Exception; end

  module Proc

    def self.included(base)
      base.class_eval do

        # Rubies of 1.8.6 & earlier doesn't support something.map(&:blah)
        meths = instance_methods.map{|m| m.to_s }

        unless meths.include?('source_location')

          # Added as a bonus, by default, only 1.9.* implements this.
          def source_location
            unless created_on_the_fly?
              @source_location ||= (
                file, line = /^#<Proc:0x[0-9A-Fa-f]+@(.+):(\d+).*?>$/.match(inspect)[1..2]
                [file, line.to_i]
              )
            end
          end

          # HACK to make it easy to determine if a proc is created on the fly
          ::Proc.class_eval do
            attr_writer :created_on_the_fly
            def created_on_the_fly?
              !!@created_on_the_fly
            end
          end

          [::Method, ::Symbol].each do |klass|
            begin
              klass.class_eval do
                alias_method :__pre_sourcified_to_proc, :to_proc
                def to_proc
                  (_proc = __pre_sourcified_to_proc).created_on_the_fly = true
                  _proc
                end
              end
            rescue NameError
            end
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
