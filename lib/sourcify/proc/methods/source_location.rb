module Sourcify
  module Proc
    module Methods
      module SourceLocation
        def self.included(base)
          base.class_eval do
            unless lambda{}.respond_to?(:source_location)

              def source_location
                unless @created_on_the_fly # see below hack
                  @source_location ||= (
                    file, line = /^#<Proc:0x[0-9A-Fa-f]+@(.+):(\d+).*?>$/.match(inspect)[1..2]
                    [file, line.to_i]
                  )
                end
              end

              # The rest are hacks to ease determining of procs that are created on the fly, in
              # order to ensure identical behaviour to what is already provided by 1.9.* ..

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
end
