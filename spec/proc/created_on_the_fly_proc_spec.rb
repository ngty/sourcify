require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Created on the fly proc" do
  unless Object.const_defined?(:ParseTree)

    klass = Class.new do
      def test(&block); block ; end
      def blah; 1+2; end
    end

    describe 'Blah#to_proc raising Sourcify::CannotHandleCreatedOnTheFlyProcError' do

      should "raise when created by :to_proc" do
        lambda {
          x, y = klass.new.method(:test).to_proc, lambda { 1+2 }
          x.to_source
        }.should.raise(Sourcify::CannotHandleCreatedOnTheFlyProcError)
      end

      should "not raise even with prepending :to_proc on the same line" do
        x, y = klass.new.method(:test).to_proc, lambda { 1+2 }
        y.to_source.should.not.be.nil
      end

      should "not raise even with appending :to_proc on the same line" do
        x, y = lambda { 1+2 }, klass.new.method(:test).to_proc
        x.to_source.should.not.be.nil
      end

      should "not raise even with nested :to_proc on the same line" do
        x = lambda { klass.new.method(:test).to_proc }
        x.to_source.should.not.be.nil
      end

    end

    if RUBY_VERSION.include?('1.9.') or RUBY_PLATFORM =~ /java/i

      describe '&:blah raising Sourcify::CannotHandleCreatedOnTheFlyProcError' do

        should "raise when created by &:blah" do
          lambda {
            x, y = klass.new.test(&:blah), lambda { 1+2 }
            x.to_source
          }.should.raise(Sourcify::CannotHandleCreatedOnTheFlyProcError)
        end

        should "not raise even with prepending &:blah on the same line" do
          x, y = klass.new.test(&:blah), lambda { 1+2 }
          y.to_source.should.not.be.nil
        end

        should "not raise even with appending &:blah on the same line" do
          x, y = lambda { 1+2 }, klass.new.test(&:blah)
          x.to_source.should.not.be.nil
        end

        should "not raise even with nested &:blah on the same line" do
          x = lambda { klass.new.test(&:blah) }
          x.to_source.should.not.be.nil
        end

      end

    else

      describe '&:blah raising Sourcify::CannotHandleCreatedOnTheFlyProcError' do

        should "raise w no other proc on the same line" do
          lambda {
            x = klass.new.test(&:blah)
            x.to_source
          }.should.raise(Sourcify::CannotHandleCreatedOnTheFlyProcError)
        end

        should "raise w prepending proc of different arity on the same line" do
          lambda {
            y, x = lambda {|a| 1+2 }, klass.new.test(&:blah)
            x.to_source
          }.should.raise(Sourcify::CannotHandleCreatedOnTheFlyProcError)
        end

        should "raise w appending proc of different arity on the same line" do
          lambda {
            x, y = klass.new.test(&:blah), lambda {|a| 1+2 }
            x.to_source
          }.should.raise(Sourcify::CannotHandleCreatedOnTheFlyProcError)
        end

        should "raise w nested proc of different arity on the same line" do
          lambda {
            y = lambda {|a| klass.new.test(&:blah) }
            x = y.call(1).to_source
          }.should.raise(Sourcify::CannotHandleCreatedOnTheFlyProcError)
        end

      end

      describe '&:blah raising Sourcify::MultipleMatchingProcsPerLineError' do

        should 'raise w prepending proc w zero arg (arity -1) on the same line' do
          lambda {
            y, x = lambda { 1+2 }, klass.new.test(&:blah)
            x.to_source
          }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
        end

        should 'raise w appending proc w zero arg (arity -1) on the same line' do
          lambda {
            x, y = klass.new.test(&:blah), lambda { 1+2 }
            x.to_source
          }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
        end

        should 'raise w nested proc w zero arg (arity -1) on the same line' do
          lambda {
            x = lambda { klass.new.test(&:blah) }
            x.call.to_source
          }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
        end

        should 'raise w prepending proc w single optional arg (arity -1) on the same line' do
          lambda {
            y, x = lambda {|*a| 1+2 }, klass.new.test(&:blah)
            x.to_source
          }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
        end

        should 'raise w appending proc w single optional arg (arity -1) on the same line' do
          lambda {
            x, y = klass.new.test(&:blah), lambda {|*a| 1+2 }
            x.to_source
          }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
        end

        should 'raise w nested proc w single optional arg (arity -1) on the same line' do
          lambda {
            x = lambda {|*a| klass.new.test(&:blah) }
            x.call.to_source
          }.should.raise(Sourcify::MultipleMatchingProcsPerLineError)
        end

      end

    end

  end
end
