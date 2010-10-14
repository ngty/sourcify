module Sourcify
  module Proc
    module Methods #:nodoc:all
      module SourceLocation
        def self.included(base)
          base.class_eval do

            # Case (1): the family of 1.9.* behaves slightly differently for created on
            # the fly proc, eg. 1.9.2 does yield meaningful Proc#source_location for procs
            # created from Method#to_proc. Since it is not possible to derive the same
            # behaviour for other rubies, we stick to the less performant behaviour.
            if lambda{}.respond_to?(:source_location)

              alias_method :__pre_sourcified_source_location, :source_location

              def source_location(get_original = true)
                if get_original
                  __pre_sourcified_source_location
                elsif !@created_on_the_fly
                  __pre_sourcified_source_location
                end
              end

            # Case (2): okko, we are on rubies that don't support Proc#source_location ..
            else

              def source_location(get_original = true)
                unless @created_on_the_fly
                  @source_location ||= (
                    file, line = /^#<Proc:0x[0-9A-Fa-f]+@(.+):(\d+).*?>$/.match(inspect)[1..2]
                    [file, line.to_i]
                  )
                end
              end

            end

            # HACK to make it real easy to determine if a proc is created on the fly
            # (eg. Method#to_proc & Symbol#to_proc).

            attr_writer :created_on_the_fly

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
        end
      end
    end
  end
end
