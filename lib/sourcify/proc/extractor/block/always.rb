module Sourcify
  module Proc
    module Extractor
      module Block
        module Always

          def always_true(*flags)
            flags.each do |flag|
              send(:define_method, flag) { true }
            end
          end

          def always_false(*flags)
            flags.each do |flag|
              send(:define_method, flag) { false }
            end
          end

        end
      end
    end
  end
end
