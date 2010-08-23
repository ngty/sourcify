require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested case)" do

  should 'handle simple' do
    (
      lambda do
        case @x1 when true then false end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:case, s(:ivar, :@x1), s(:when, s(:array, s(:true)), s(:false)), nil))
    )
  end

  should 'handle nested' do
    (
      lambda do
        case @x1
        when true
          case @x2 when false then true end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:case,
          s(:ivar, :@x1),
          s(:when,
            s(:array, s(:true)),
            s(:case, s(:ivar, :@x2), s(:when, s(:array, s(:false)), s(:true)), nil)),
                 nil))
    )
  end

end
