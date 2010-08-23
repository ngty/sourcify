require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested class)" do

  should 'handle simple' do
    (
      lambda do
        class AA
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:class,
          :AA,
          nil,
          s(:scope,
            s(:defn,
              :aa,
              s(:args),
              s(:scope, s(:block, s(:iasgn, :@x1, s(:lit, 1))))))))
    )
  end

  should 'handle inheritance' do
    (
      lambda do
        class AA < Object
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:class,
          :AA,
          s(:const, :Object),
          s(:scope,
            s(:defn,
              :aa,
              s(:args),
              s(:scope, s(:block, s(:iasgn, :@x1, s(:lit, 1))))))))
    )
  end

  should 'handle singleton' do
    (
      lambda do
        class << 'AA'
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:sclass,
          s(:str, "AA"),
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
        class AA
          class BB
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
        s(:class,
          :AA,
          nil,
          s(:scope,
            s(:class,
              :BB,
              nil,
              s(:scope,
                s(:defn,
                  :bb,
                  s(:args),
                  s(:scope, s(:block, s(:iasgn, :@x1, s(:lit, 1))))))))))
    )
  end

end
