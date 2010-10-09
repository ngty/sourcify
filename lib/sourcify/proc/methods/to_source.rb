module Sourcify
  module Proc
    module Methods
      module ToSource
        def self.included(base)
          base.class_eval do

            ref_proc = lambda {}

            # Case 1: the current ruby already implements Proc#to_source, we just override it
            # to ensure passing in extra args won't break it.
            if ref_proc.respond_to?(:to_source)

              alias_method :__pre_sourcified_to_source, :to_source

              def to_source(opts = {})
                __pre_sourcified_to_source
              end

            # Case 2: we have Proc#to_ruby (provided by ParseTree) available, let's have a thin
            # wrapper round it.
            elsif ref_proc.respond_to?(:to_ruby)

              def to_source(opts = {})
                to_ruby
              end

            # Case 3: okko, we have to implement our own Proc#to_source ...
            else

              def to_source(opts = {})
                Sourcify.require_rb('proc', 'parser')
                (@parser ||= Parser.new(self, opts)).source
              end

            end
          end
        end
      end
    end
  end
end
