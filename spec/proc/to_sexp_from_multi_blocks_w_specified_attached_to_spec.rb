require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_sexp w specified {:attached_to => ...}' do

  # NOTE: We just want enough specs to show that handling of :attached_to
  # works for Proc#to_sexp as well.

  options = {:attached_to => /^.*?(\W|)watever(\W)/}

  should 'handle no nesting on same line' do
    b1 = lambda {|a| @x1+1 }; b2 = watever { @x1+2 }; b3 = lambda { @x1+3 }
    b2.should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:call, s(:ivar, :@x1), :+, s(:arglist, s(:lit, 2)))),
      options
    )
  end

  should 'handle single level nesting on same line' do
    b1 = lambda {|a| @x2+1 }; b2 = watever { lambda { @x2+2 } }
    b2.should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:iter,
          s(:call, nil, :lambda, s(:arglist)),
          nil,
          s(:call, s(:ivar, :@x2), :+, s(:arglist, s(:lit, 2))))),
      options
    )
  end

  should 'handle multi level nesting on same line' do
    b2 = (lambda {|a| watever { lambda { @x3 } } }).call(1)
    b2.should.be having_sexp(
      s(:iter,
        s(:call, nil, :proc, s(:arglist)),
        nil,
        s(:iter, s(:call, nil, :lambda, s(:arglist)), nil, s(:ivar, :@x3))),
      options
    )
  end

end
