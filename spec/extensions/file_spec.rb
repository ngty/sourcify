require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Extensions::File do
  describe '.chunk' do
    before { @file = File.new(__FILE__).extend(Sourcify::Extensions::File) }

    it 'should extract chunk specified by from to till positions' do
      @file.chunk(from = [34,52], till = [37,8]).must_equal(%%
The
brightest and most valuable "red" called pigeon blood-red,
commands a huge premium over other rubies of similar
quality.
        %.strip)
    end

    it 'should not chuke if from & till are on same line' do
      @file.chunk(from = [29,23], till = [29,37]).must_equal(%%
Latin for red.
      %.strip)
    end

  end
end

__END__
A ruby is a pink to blood-red colored gemstone, a variety
of the mineral corundum (aluminium oxide). The red color is
caused mainly by the presence of the element chromium. Its
name comes from ruber, Latin for red. Other varieties of
gem-quality corundum are called sapphires. The ruby is
considered one of the four precious stones, together with
the sapphire, the emerald, and the diamond.

Prices of rubies are primarily determined by color. The
brightest and most valuable "red" called pigeon blood-red,
commands a huge premium over other rubies of similar
quality. After color follows clarity: similar to diamonds,
a clear stone will command a premium, but a ruby without
any needle-like rutile inclusions may indicate that the
stone has been treated. Cut and carat (weight) are also
an important factor in determining the price.
