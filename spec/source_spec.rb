require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Source do
  extend Sourcify::SpecHelper

  before do
    @raw = "lambda { :thing }"
    @stripped = ":thing"
    @source = Sourcify::Source.new(@raw.dup, @stripped.dup)
  end


  describe '#to_s' do
    it 'must return the raw form' do
      @source.to_s.must_equal(@raw)
    end

    it 'must return instance of String' do
      @source.to_s.must_be_instance_of(String)
    end
  end


  describe '#to_str' do
    it 'must return the raw form' do
      @source.to_str.must_equal(@raw)
    end

    it 'must return instance of String' do
      @source.to_str.must_be_instance_of(String)
    end
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
      @source.must_equal(Sourcify::Source.new(@stripped, @stripped))
    end
  end


  describe '#<=>' do
    it 'must return 1 if it is bigger than other' do
      smaller = Sourcify::Source.new(@raw.upcase, @stripped.downcase)
      (@source <=> smaller).must_equal(1)
    end

    it 'must return -1 if it is smaller than other' do
      smaller = Sourcify::Source.new(@raw.upcase, @stripped.downcase)
      (smaller <=> @source).must_equal(-1)
    end

    it 'must return 0 if it is equal to other' do
      same = Sourcify::Source.new(@raw, @stripped.upcase)
      (@source <=> same).must_equal(0)
    end
  end


  describe '#==' do
    it 'must return true if other is a Sourcify::Source & has the same raw form' do
      @source.must_equal(Sourcify::Source.new(@raw, "watever"))
    end

    it 'must return false if other is a Sourcify::Source & has different raw form' do
      @source.wont_equal(Sourcify::Source.new("watever", @stripped))
    end

    it 'must return true if the stringified other is the same as the raw form' do
      (@source == :"#{@raw}").must_equal(true)
    end

    it 'must return false if the stringified other is different from the raw form' do
      (@source == :watever).must_equal(false)
    end
  end


  "".public_methods(false).select{|m| m.to_s.end_with?('!') }.each do |m_bang|
    next if [:strip!].include?(m_bang)
    next if "".method(m_bang).arity.nonzero? # keep it simple
    m = m_bang.to_s.sub('!','')

    describe "##{m_bang}" do
      it 'must return nil' do
        @source.send(m_bang).must_equal(nil)
      end

      it "must convert self to Sourcify::Source of #{m}" do
        new_source = Sourcify::Source.new(@raw.send(m), @stripped.send(m))

        @source.send(m_bang)
        @source.must_equal(new_source)
      end
    end
  end


  "".public_methods(false).reject{|m| m.to_s.end_with?('!') }.each do |m|
    next if [:to_s, :to_str, :strip, :==].include?(m)
    next if [:bytes, :chars, :codepoints].include?(m) # keep it simple
    next if m.to_s.start_with?('each_') # keep it simple
    next if "".method(m).arity.nonzero? # keep it

    describe "##{m}" do
      it 'must return instance of Sourcify::Source' do
        @source.send(m).must_be_instance_of(Sourcify::Source)
      end

      it "must return the #{m}-ed form" do
        new_source = Sourcify::Source.new(@raw.send(m), @stripped.send(m))
        @source.send(m).must_equal(new_source)
      end
    end
  end

end
