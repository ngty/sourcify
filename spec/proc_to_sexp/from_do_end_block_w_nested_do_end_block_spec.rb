require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested do ... end block)" do

  should 'handle simple' do
    (
      lambda do
        lambda do @x1 = 1 end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:iter,
          s(:call, nil, :lambda, s(:arglist)),
          nil,
          s(:iasgn, :@x1, s(:lit, 1))))
    )
  end

  should 'handle nested' do
    (
      lambda do
        lambda do
          lambda do @x1 = 1 end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:iter,
          s(:call, nil, :lambda, s(:arglist)),
          nil,
          s(:iter,
            s(:call, nil, :lambda, s(:arglist)),
            nil,
            s(:iasgn, :@x1, s(:lit, 1)))))
    )
  end

end
