require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'Proc#to_source from multi blocks w many matches' do

  if has_parsetree?

    expected = 'proc { @x%s }'

    should 'skip non-matching (all do...end blocks)' do
      (
        b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end; b3 = lambda do @x10 end; b2
      ).should.be having_source(expected%1)
    end

    should 'skip non-matching (all {...} blocks)' do
      (
        b1 = lambda {|a| @x2 }; b2 = lambda { @x2 }; b3 = lambda { @x20 }; b2
      ).should.be having_source(expected%2)
    end

    should 'skip non-matching (mixed {...} with do...end blocks)' do
      (
        b1 = lambda {|a| @x3 }; b2 = lambda do @x3 end; b3 = lambda { @x30 } ; b2
      ).should.be having_source(expected%3)
    end

    should 'skip non-matching (mixed do...end with {...} blocks)' do
      (
        b1 = lambda do |a| @x4 end; b2 = lambda { @x4 }; b3 = lambda do @x40 end; b2
      ).should.be having_source(expected%4)
    end

  else

    describe '>> wo nesting on same line' do

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (all do...end blocks)' do
        lambda {
          (
            b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end; b3 = lambda do @x1 end ; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (all {...} blocks)' do
        lambda {
          (
            b1 = lambda {|a| @x2 }; b2 = lambda { @x2 }; b3 = lambda { @x2 } ; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (mixed {...} w do...end blocks)' do
        lambda {
          (
            b1 = lambda {|a| @x3 }; b2 = lambda do @x3 end; b3 = lambda { @x4 } ; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (mixed do...end w {...} blocks)' do
        lambda {
          (
            b1 = lambda do |a| @x4 end; b2 = lambda { @x4 }; b3 = lambda do @x4 end ; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

    end

    describe '>> w single level nesting on same line' do

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (all do...end blocks)' do
        lambda {
          (
            b1 = lambda do |a| @x1 end; b2 = lambda do lambda do @x1 end end; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (all {...} blocks)' do
        lambda {
          (
            b1 = lambda {|a| @x2 }; b2 = lambda { lambda { @x2 } }; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (mixed {...} w do...end blocks)' do
        lambda {
          (
            b1 = lambda {|a| @x3 }; b2 = lambda do lambda { @x4 } end; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (mixed do...end w {...} blocks)' do
        lambda {
          (
            b1 = lambda do |a| @x4 end; b2 = lambda { lambda do @x4 end }; b2
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

    end

    describe '>> w multi level nesting on same line' do

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (all do...end blocks)' do
        lambda {
          (
            b1 = lambda do |a| lambda do lambda do @x1 end end end
            b2 = b1.call(1)
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (all {...} blocks)' do
        lambda {
          (
            b1 = lambda {|a| lambda { lambda { @x2 } } }
            b2 = b1.call(1)
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (mixed {...} w do...end blocks)' do
        lambda {
          (
            b1 = lambda {|a| lambda do lambda { @x4 } end }
            b2 = b1.call(1)
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

      should 'raise Sourcify::MultipleMatchingProcsPerLineError (mixed do...end w {...} blocks)' do
        lambda {
          (
            b1 = lambda do |a| lambda { lambda do @x4 end } end
            b2 = b1.call(1)
          ).to_source
        }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
      end

    end

  end

end
