require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from { ... } block (w nested { ... } block)" do

  should 'handle simple' do
    (
      lambda {
        lambda { @x1 = 1 }
      }
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
      lambda {
        lambda {
          lambda { @x1 = 1 }
        }
      }
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
