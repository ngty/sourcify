require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::RawSource do

  before do
    @proc = proc do
      # blah blah
      :nil
    end

    source = Sourcify::Proc::Source.new(__FILE__, __LINE__ - 5)
    @raw_source = Sourcify::Proc::RawSource.new(source.metadata)
  end


  describe '#to_s' do
    it 'should return source with comments preserved' do
      @raw_source.to_s.must_equal(%%
        proc do
          # blah blah
          :nil
        end
      %.strip.gsub(/\n        /m, "\n"))
    end
  end

end
