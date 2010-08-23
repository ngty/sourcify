require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested module)" do

  should 'handle simple' do
    (
      lambda do
        module AA
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:module,
          :AA,
          s(:scope,
            s(:defn,
              :aa,
              s(:args),
              s(:scope, s(:block, s(:iasgn, :@x1, s(:lit, 1))))))))
    )
  end

  should 'handle nested' do
    (
      lambda do
        module AA
          module BB
            def bb
              @x1 = 1
            end
          end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:module,
          :AA,
          s(:scope,
            s(:module,
              :BB,
              s(:scope,
                s(:defn,
                  :bb,
                  s(:args),
                  s(:scope, s(:block, s(:iasgn, :@x1, s(:lit, 1))))))))))
    )
  end

end
