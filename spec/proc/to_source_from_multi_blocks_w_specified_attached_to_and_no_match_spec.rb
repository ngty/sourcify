require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'Proc#to_source w specified {:attached_to => ...} & no match' do

  options = {:attached_to => /^.*?(\W|)forever(\W)/}

  if has_parsetree?

    should 'handle no nesting on same line' do
      b1 = lambda do |a| @x1+1 end; b2 = lambda do @x1+2 end; b3 = lambda do @x1+3 end
      b2.should.be having_source('proc { @x1+2 }', options)
    end

    should 'handle single level nesting on same line' do
      b1 = lambda do |a| @x2+1 end; b2 = lambda do lambda do @x2+2 end end
      b2.should.be having_source('proc { lambda { @x2+2 } }', options)
    end

    should 'handle multi level nesting on same line' do
      b2 = (lambda do |a| lambda do lambda do @x3 end end end).call(1)
      b2.should.be having_source('proc { lambda { @x3 } }', options)
    end

  else

    describe '>> wo nesting on same line' do

      should 'raise Sourcify::NoMatchingProcError (all do...end blocks)' do
        b1 = lambda do |a| @x1+1 end; b2 = watever do @x1+2 end; b3 = lambda do @x1+3 end
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (all {...} blocks)' do
        b1 = lambda {|a| @x2+1 }; b2 = watever { @x2+2 }; b3 = lambda { @x2+3 }
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (mixed {...} w do...end blocks)' do
        b1 = lambda {|a| @x3+1 }; b2 = watever do @x3+2 end; b3 = lambda { @x3+3 }
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (mixed do...end w {...} blocks)' do
        b1 = lambda do |a| @x4+1 end; b2 = watever { @x4+2 }; b3 = lambda do @x4+3 end
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

    end

    describe '>> w single level nesting on same line' do

      should 'raise Sourcify::NoMatchingProcError (all do...end blocks)' do
        b1 = lambda do |a| @x1+1 end; b2 = watever do lambda do @x1+2 end end
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (all {...} blocks)' do
        b1 = lambda {|a| @x2+1 }; b2 = watever { lambda { @x2+2 } }
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (mixed {...} w do...end blocks)' do
        b1 = lambda {|a| @x3+1 }; b2 = watever do lambda { @x3+2 } end
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (mixed do...end w {...} blocks)' do
        b1 = lambda do |a| @x4+1 end; b2 = watever { lambda do @x4+2 end }
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

    end

    describe '>> w multi level nesting on same line' do

      should 'raise Sourcify::NoMatchingProcError (all do...end blocks)' do
        b2 = (lambda do |a| watever do lambda do @x1 end end end).call(1)
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (all {...} blocks)' do
        b2 = (lambda {|a| watever { lambda { @x2 } } }).call(1)
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (mixed {...} w do...end blocks)' do
        b2 = (lambda {|a| watever do lambda { @x3 } end }).call(1)
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

      should 'raise Sourcify::NoMatchingProcError (mixed do...end w {...} blocks)' do
        b2 = (lambda do |a| watever { lambda do @x4 end } end).call(1)
        lambda { b2.to_source(options) }.should.raise(Sourcify::NoMatchingProcError)
      end

    end

  end

end
