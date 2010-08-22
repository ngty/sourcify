module ToSource
  module Proc

    def self.included(base)
      base_methods = base.instance_methods.map(&:to_s)
      base.class_eval do

        if base_methods.include?('to_ruby')
          puts 'called '
          alias_method :to_source, :to_ruby
        elsif !base_methods.include?('to_source')
          include SourceMethods
        end

        include SexpMethods unless base_methods.include?('to_sexp')

      end
    end

    module SourceMethods
      def to_source
      end
    end

    module SexpMethods
      def to_sexp
      end
    end

  end
end

::Proc.class_eval do
  include ToSource::Proc
end
