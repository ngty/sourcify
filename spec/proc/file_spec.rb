require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::File do
  describe '.chunk' do
    it 'should extract chunk specified by from & till positions' do
      Sourcify::Proc::File.chunk(__FILE__, [25,52], [28,8]).must_equal(%%
The
brightest and most valuable "red" called pigeon blood-red,
commands a huge premium over other rubies of similar
quality.
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
