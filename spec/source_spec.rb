require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Source do
  extend Sourcify::SpecHelper

  before do
    @raw, @stripped = "lambda { :thing }", ":thing"
    @source = Sourcify::Source.new(@raw.dup, @stripped.dup)
  end

  describe '#strip' do
    it 'must return the stripped form' do
      @source.strip.must_equal(@stripped)
    end

    it 'must return an instance of Sourcify::Source' do
      @source.strip.must_be_instance_of(Sourcify::Source)
    end
  end

  describe "#strip!" do
    it 'must return nil' do
      @source.strip!.must_equal(nil)
    end

    it "must convert self to Sourcify::Source of stripped form" do
      @source.strip!
      @source.must_be_instance_of(Sourcify::Source)
      @source.must_equal(@stripped)
    end
  end


  # Sparingly check for delegation to @raw

  describe '#<=>' do
    it 'must return 1 if the raw form is bigger than other' do
      (@source <=> @raw.upcase).must_equal(1)
    end

    it 'must return -1 if the raw form is smaller than other' do
      (@raw.upcase <=> @source).must_equal(-1)
    end

    it 'must return 0 if the raw form is equal to other' do
      (@source <=> @raw).must_equal(0)
    end
  end

  describe '#==' do
    it 'must return true if the raw form is the same as other' do
      @source.must_equal(@raw)
    end

    it 'must return false if the raw form is different from the other' do
      @source.wont_equal(@stripped)
    end
  end

end
