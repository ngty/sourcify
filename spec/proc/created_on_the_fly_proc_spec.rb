require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Created on the fly proc" do
  unless has_parsetree?

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

      should "not raise even with prepending #to_proc on the same line" do
        x, y = klass.new.method(:test).to_proc, lambda { 1+2 }
        y.to_source.should.not.be.nil
      end

      should "not raise even with appending #to_proc on the same line" do
        x, y = lambda { 1+2 }, klass.new.method(:test).to_proc
        x.to_source.should.not.be.nil
      end

      should "not raise even with nested #to_proc on the same line" do
        x = lambda { klass.new.method(:test).to_proc }
        x.to_source.should.not.be.nil
      end

      should "not raise with nested #to_proc on diff line" do
        (
          lambda do
            klass.new.method(:test).to_proc
          end
        ).to_source.should.not.be.nil
      end

    end

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

      should "not raise with nested &:blah on diff line" do
        (
          lambda do
            klass.new.test(&:blah)
          end
        ).to_source.should.not.be.nil
      end

    end

  end
end
