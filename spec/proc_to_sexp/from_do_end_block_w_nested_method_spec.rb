require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested method)" do

  should 'handle simple' do
    (
      lambda do
        def aa; x = 1; end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:defn, :aa, s(:args), s(:scope, s(:block, s(:lasgn, :x, s(:lit, 1))))))
    )
  end

  should 'handle nested' do
    (
      lambda do
        def aa
          def bb; x = 2; end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:defn,
          :aa,
          s(:args),
          s(:scope,
            s(:block,
              s(:defn,
                :bb,
                s(:args),
                s(:scope, s(:block, s(:lasgn, :x, s(:lit, 2)))))))))
    )
  end

end
