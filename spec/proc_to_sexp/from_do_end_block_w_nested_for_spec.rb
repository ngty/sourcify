require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_sexp from do ... end block (w nested for block)" do

  should 'handle w do' do
    (
      lambda do
        for x1 in [1,2] do x1 end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:for, s(:array, s(:lit, 1), s(:lit, 2)), s(:lasgn, :x1), s(:lvar, :x1)))
    )
  end

  should 'handle w \ do' do
    (
      lambda do
        for x2 in [1,2] \
          do x2 end
      end
    ).should.be having_sexp(
      s(:iter,
         s(:call, nil, :proc, s(:arglist)),
          nil,
           s(:for, s(:array, s(:lit, 1), s(:lit, 2)), s(:lasgn, :x2), s(:lvar, :x2)))
    )
  end

  should 'handle wo do (w newline)' do
    (
      lambda do
        for x3 in [1,2]
          x3
        end
      end
    ).should.be having_sexp(
      s(:iter,
         s(:call, nil, :proc, s(:arglist)),
          nil,
           s(:for, s(:array, s(:lit, 1), s(:lit, 2)), s(:lasgn, :x3), s(:lvar, :x3)))
    )
  end

  should 'handle wo do (w semicolon)' do
    (
      lambda do
        for x4 in [1,2]; x4; end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:for, s(:array, s(:lit, 1), s(:lit, 2)), s(:lasgn, :x4), s(:lvar, :x4)))
    )
  end

  should 'handle nested wo do within w do' do
    (
      lambda do
        for x1 in [1,2] do
          for x2 in [1,2]
            x2
          end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:for,
          s(:array, s(:lit, 1), s(:lit, 2)),
          s(:lasgn, :x1),
          s(:for, s(:array, s(:lit, 1), s(:lit, 2)), s(:lasgn, :x2), s(:lvar, :x2))))
    )
  end

  should 'handle nested wo do within wo do' do
    (
      lambda do
        for x1 in [2,3]
          for x2 in [2,3]
            x2
          end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:for,
          s(:array, s(:lit, 2), s(:lit, 3)),
          s(:lasgn, :x1),
          s(:for, s(:array, s(:lit, 2), s(:lit, 3)), s(:lasgn, :x2), s(:lvar, :x2))))
    )
  end

  should 'handle nested w do within wo do' do
    (
      lambda do
        for x1 in [3,4]
          for x2 in [3,4] do x2 end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:for,
          s(:array, s(:lit, 3), s(:lit, 4)),
          s(:lasgn, :x1),
          s(:for, s(:array, s(:lit, 3), s(:lit, 4)), s(:lasgn, :x2), s(:lvar, :x2))))
    )
  end

  should 'handle nested w do within w do' do
    (
      lambda do
        for x1 in [4,5] \
          do for x2 in [4,5] do x2 end
        end
      end
    ).should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:for,
          s(:array, s(:lit, 4), s(:lit, 5)),
          s(:lasgn, :x1),
          s(:for, s(:array, s(:lit, 4), s(:lit, 5)), s(:lasgn, :x2), s(:lvar, :x2))))
    )
  end

end
