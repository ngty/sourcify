require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested if)" do

  should 'handle simple block' do
    (
      lambda do
        if @x1 then @x1 = 1 end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if, s(:ivar, :@x1), s(:iasgn, :@x1, s(:lit, 1)), nil))
    )
  end

  should 'handle nested block' do
    (
      lambda do
        if @x1
          if @x2 then @x2 = 1 end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if,
          s(:ivar, :@x1),
          s(:if, s(:ivar, :@x2), s(:iasgn, :@x2, s(:lit, 1)), nil),
               nil))
    )
  end

  should 'handle simple modifier' do
    (
      lambda do
        @x1 = 1 if @x1
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if, s(:ivar, :@x1), s(:iasgn, :@x1, s(:lit, 1)), nil))
    )
  end

  should 'handle block within modifier' do
    (
      lambda do
        @x1 = 1 if (if @x1 then @x2 end)
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if,
          s(:if, s(:ivar, :@x1), s(:ivar, :@x2), nil),
               s(:iasgn, :@x1, s(:lit, 1)),
               nil))
    )
  end

  should 'handle modifier within block' do
    (
      lambda do
        if @x1
          @x1 = 2 if @x2
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:if,
          s(:ivar, :@x1),
          s(:if, s(:ivar, :@x2), s(:iasgn, :@x1, s(:lit, 2)), nil),
               nil))
    )
  end

end
