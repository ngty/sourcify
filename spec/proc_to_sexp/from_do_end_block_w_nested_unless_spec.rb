require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested unless)" do

  should 'handle simple block' do
    (
      lambda do
        unless @x1 then @x1 = 1 end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if, s(:ivar, :@x1), nil, s(:iasgn, :@x1, s(:lit, 1))))
    )
  end

  should 'handle nested block' do
    (
      lambda do
        unless @x1
          unless @x2 then @x2 = 1 end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if,
          s(:ivar, :@x1),
          nil,
          s(:if, s(:ivar, :@x2), nil, s(:iasgn, :@x2, s(:lit, 1)))))
    )
  end

  should 'handle simple modifier' do
    (
      lambda do
        @x1 = 1 unless true
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if, s(:true), nil, s(:iasgn, :@x1, s(:lit, 1))))
    )
  end

  should 'handle block within modifier' do
    (
      lambda do
        @x1 = 1 unless (unless @x1 then true end)
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if,
          s(:if, s(:ivar, :@x1), nil, s(:true)),
               nil,
               s(:iasgn, :@x1, s(:lit, 1))))
    )
  end

  should 'handle modifier within block' do
    (
      lambda do
        unless @x1
          @x1 = 1 unless @x2
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if,
          s(:ivar, :@x1),
          nil,
          s(:if, s(:ivar, :@x2), nil, s(:iasgn, :@x1, s(:lit, 1)))))
    )
  end

end
