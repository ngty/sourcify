shared 'Proc#to_source from { ... } block (1.9.*)' do

  should 'handle simple (w label keys)' do
    (
      lambda {
        {a: 1, b: 2}
      }
    ).should.be having_source(%Q\
      proc do
        {:a => 1, :b => 2}
      end
    \)
  end

  should 'handle nested (w label keys)' do
    (
      lambda {
        {a: 1, b: {c: 3}}
      }
    ).should.be having_source(%Q\
      proc do
        {:a => 1, :b => {:c => 3}}
      end
    \)
  end

end

shared 'Proc#to_source from multi blocks w many matches spec (1.9.*)' do

  # Need this line since the parser file is dynamically required, otherwise we will get
  # undefined constant error
  require 'to_source/proc/parser19'

  should 'raise ToSource::Proc::Parser::AmbiguousMatchError (all do...end blocks)' do
    lambda {
      (
        b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end; b3 = lambda do @x1 end ; b2
      ).to_source
    }.should.raise(ToSource::Proc::Parser::AmbiguousMatchError)
  end

  should 'raise ToSource::Proc::Parser::AmbiguousMatchError (all {...} blocks)' do
    lambda {
      (
        b1 = lambda {|a| @x2 }; b2 = lambda { @x2 }; b3 = lambda { @x2 } ; b2
      ).to_source
    }.should.raise(ToSource::Proc::Parser::AmbiguousMatchError)
  end

  should 'raise ToSource::Proc::Parser::AmbiguousMatchError (mixed {...} w do...end blocks)' do
    lambda {
      (
        b1 = lambda {|a| @x3 }; b2 = lambda do @x3 end; b3 = lambda { @x4 } ; b2
      ).to_source
    }.should.raise(ToSource::Proc::Parser::AmbiguousMatchError)
  end

  should 'raise ToSource::Proc::Parser::AmbiguousMatchError (mixed do...end w {...} blocks)' do
    lambda {
      (
        b1 = lambda do |a| @x4 end; b2 = lambda { @x4 }; b3 = lambda do @x4 end ; b2
      ).to_source
    }.should.raise(ToSource::Proc::Parser::AmbiguousMatchError)
  end

end
