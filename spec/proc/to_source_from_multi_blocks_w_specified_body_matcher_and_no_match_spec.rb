require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified body matcher & no match' do

  matcher = lambda {|code| code =~ /^(.*\W|)def\W/ }

  if has_parsetree?

    should 'handle no nesting on same line' do
      b1 = lambda do |a| @x1+1 end; b2 = lambda do @x1+2 end; b3 = lambda do @x1+3 end
      b2.should.be having_source('proc { @x1+2 }', &matcher)
    end

    should 'handle single level nesting on same line' do
      b1 = lambda do |a| @x2+1 end; b2 = lambda do lambda do @x2+2 end end
      b2.should.be having_source('proc { lambda { @x2+2 } }', &matcher)
    end

    should 'handle multi level nesting on same line' do
      b2 = (lambda do |a| lambda do lambda do @x3 end end end).call(1)
      b2.should.be having_source('proc { lambda { @x3 } }', &matcher)
    end

  else

    error = Sourcify::NoMatchingProcError

    should "raise #{error} w no nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { @x }; b3 = lambda { @x }
      lambda { b2.to_source(&matcher) }.should.raise(error)
    end

    should "raise #{error} w single level nesting on same line" do
      b1 = lambda {|a| @x }; b2 = lambda { lambda { @x } }
      lambda { b2.to_source(&matcher) }.should.raise(error)
    end

    should "raise #{error} w multi level nesting on same line" do
      b2 = (lambda {|a| lambda { lambda { @x } } }).call(1)
      lambda { b2.to_source(&matcher) }.should.raise(error)
    end

  end

end
