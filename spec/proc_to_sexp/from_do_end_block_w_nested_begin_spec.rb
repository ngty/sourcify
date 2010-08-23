require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested begin)" do

  should 'handle simple' do
    (
      lambda do
        begin @x1 = 1 end
      end
    ).should.be having_sexp(
      s(:iter, s(:call, nil, :proc, s(:arglist)), nil, s(:iasgn, :@x1, s(:lit, 1)))
    )
  end

  should 'handle nested' do
    (
      lambda do
        begin
          @x1 = 1
          begin @x2 = 2 end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:block, s(:iasgn, :@x1, s(:lit, 1)), s(:iasgn, :@x2, s(:lit, 2))))
    )
  end

end
