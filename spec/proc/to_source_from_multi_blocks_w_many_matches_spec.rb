require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'Proc#to_source from multi blocks w many matches' do

  if Object.const_defined?(:ParseTree)

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

    # Need this line since the parser file is dynamically required, otherwise we will get
    # undefined constant error
    require 'sourcify/proc/parser'

    should 'raise Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError (all do...end blocks)' do
      lambda {
        (
          b1 = lambda do |a| @x1 end; b2 = lambda do @x1 end; b3 = lambda do @x1 end ; b2
        ).to_source
      }.should.raise(Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError)
    end

    should 'raise Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError (all {...} blocks)' do
      lambda {
        (
          b1 = lambda {|a| @x2 }; b2 = lambda { @x2 }; b3 = lambda { @x2 } ; b2
        ).to_source
      }.should.raise(Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError)
    end

    should 'raise Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError (mixed {...} w do...end blocks)' do
      lambda {
        (
          b1 = lambda {|a| @x3 }; b2 = lambda do @x3 end; b3 = lambda { @x4 } ; b2
        ).to_source
      }.should.raise(Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError)
    end

    should 'raise Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError (mixed do...end w {...} blocks)' do
      lambda {
        (
          b1 = lambda do |a| @x4 end; b2 = lambda { @x4 }; b3 = lambda do @x4 end ; b2
        ).to_source
      }.should.raise(Sourcify::Proc::Parser::MultipleMatchingProcsPerLineError)
    end

  end

end
