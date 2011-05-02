module Sourcify
  module Proc
    class Parser #:nodoc:all
      class Normalizer
        class << self

          def process(sexp, binding)
            @binding = binding
            Sexp.from_array(fix_no_arg_method_calls(sexp.to_a))
          end

          def fix_no_arg_method_calls(array)
            return array if [:class, :sclass, :defn, :module].include?(array[0])
            array.map do |e|
              if e.is_a?(Array)
                no_arg_method_call?(e) or fix_no_arg_method_calls(e)
              else
                e
              end
            end
          end

          def no_arg_method_call?(e)
            if like_no_arg_method_call?(e)
              bounded_var?(var = e[2]) ? [:lvar, var] : e
            end
          end

          def like_no_arg_method_call?(e)
            e.size == 4 && e[0..1] == [:call, nil] &&
              e[3] == [:arglist] && (var = e[2]).is_a?(Symbol)
          end

          def bounded_var?(var)
            lvar = (@q ||= (IS_19x ? ":%s" : "'%s'")) % var
            @binding.has_local_variable?(lvar)
          end

        end
      end
    end
  end
end
