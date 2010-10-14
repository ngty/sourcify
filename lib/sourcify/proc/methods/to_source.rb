module Sourcify
  module Proc
    module Methods #:nodoc:all
      module ToSource
        def self.included(base)
          base.class_eval do

            ref_proc = lambda {}

            # Case 1: the current ruby already implements Proc#to_source,
            # we override it to ensure it handles the extra args ..
            if ref_proc.respond_to?(:to_source)

              alias_method :__pre_sourcified_to_source, :to_source

              def to_source(opts = {}, &body_matcher)
                flag = opts[:strip_enclosure]
                (@sourcified_sources ||= {})[flag] ||=
                  flag ? Ruby2Ruby.new.process(to_sexp(opts, &body_matcher)) : __pre_sourcified_to_source
              end

            # Case 2: we have Proc#to_ruby (eg. provided by ParseTree) available,
            # we have a wrapper round it to ensure it handles the extra args ..
            elsif ref_proc.respond_to?(:to_ruby)

              def to_source(opts = {}, &body_matcher)
                flag = opts[:strip_enclosure]
                (@sourcified_sources ||= {})[flag] ||=
                  flag ? Ruby2Ruby.new.process(to_sexp(opts, &body_matcher)) : to_ruby
              end

            # Case 3: okko, we have to implement our own Proc#to_source ...
            else

              Sourcify.require_rb('proc', 'parser')

              def to_source(opts = {}, &body_matcher)
                (@sourcified_parser ||= Parser.new(self)).
                  source(opts.merge(:body_matcher => body_matcher))
              end

            end
          end
        end
      end
    end
  end
end
