require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source (magic var __FILE__)" do

  should 'handle single standalone' do
    def m1; __FILE__; end
    method(:m1).should.be having_source(%(
      def m1; "#{__FILE__}"; end
    ))
  end

  should 'handle multiple standalones' do
    def m2
      [
        __FILE__, __FILE__,
        __FILE__
      ]
    end
    method(:m2).should.be having_source(%Q(
      def m2
        [
          "#{__FILE__}", "#{__FILE__}",
          "#{__FILE__}"
        ]
      end
    ))
  end

  should 'handle single interpolation' do
    def m3; "#{__FILE__}"; end
    method(:m3).should.be having_source(%(
      def m3; "#{__FILE__}"; end
    ))
  end

  should 'handle multiple interpolation (separate)' do
    def m4
      [
        "#{__FILE__}", "#{__FILE__}",
        "#{__FILE__}"
      ]
    end
    method(:m4).should.be having_source(%(
      def m4
        [
          "#{__FILE__}", "#{__FILE__}",
          "#{__FILE__}"
        ]
      end
    ))
  end

  should 'handle multiple interpolation (together)' do
    def m5
      <<EOL
#{__FILE__}, #{__FILE__},
#{__FILE__}
EOL
    end
    method(:m5).should.be having_source(%(
      def m5
        <<EOL
#{__FILE__}, #{__FILE__},
#{__FILE__}
EOL
      end
    ))
  end

  should 'handle interpolation in (") quoted string' do
    def m6; "#{__FILE__}"; end
    method(:m6).should.be having_source(%(
      def m6; "#{__FILE__}"; end
    ))
  end

  should 'handle interpolation in (%) quoted string' do
    def m7; %(#{__FILE__}); end
    method(:m7).should.be having_source(%(
      def m7; "#{__FILE__}"; end
    ))
  end

  should 'handle interpolation in (%Q) quoted string' do
    def m8; %Q(#{__FILE__}); end
    method(:m8).should.be having_source(%(
      def m8; "#{__FILE__}"; end
    ))
  end

  should 'handle interpolation in heredoc string' do
    def m9
      <<-EOL
#{__FILE__}
EOL
    end
    method(:m9).should.be having_source(%(
      def m9
        <<-EOL
#{__FILE__}
EOL
      end
    ))
  end

  should 'handle interpolation in (%r) regexp' do
    def m10; %r(#{__FILE__}); end
    method(:m10).should.be having_source(%(
      def m10; %r(#{__FILE__}); end
    ))
  end

  should 'handle interpolation in (/) regexp' do
    def m11; /#{__FILE__}/ ; end
    method(:m11).should.be having_source(%(
      def m11; %r(#{__FILE__}); end
    ))
  end

  should 'handle interpolation in (%x) command' do
    def m12; %x(echo #{__FILE__}); end
    method(:m12).should.be having_source(%(
      def m12; %x(echo #{__FILE__}); end
    ))
  end

  should 'handle interpolation in (`) command' do
    def m13; `echo #{__FILE__}`; end
    method(:m13).should.be having_source(%(
      def m13; `echo #{__FILE__}`; end
    ))
  end

  should 'handle interpolation in (%W) array' do
    def m14; %W(#{__FILE__}); end
    method(:m14).should.be having_source(%(
      def m14; %W(#{__FILE__}); end
    ))
  end

  should 'not handle interpolation in (\') quoted string' do
    def m15; '#{__FILE__}'; end
    method(:m15).should.be having_source(%(
      def m15; '\#{__FILE__}'; end
    ))
  end

  should 'not handle interpolation in (%q) quoted string' do
    def m16; %q(#{__FILE__}); end
    method(:m16).should.be having_source(%(
      def m16; '\#{__FILE__}'; end
    ))
  end

  should 'not handle interpolation in (%w) array' do
    def m17; %w(#{__FILE__}); end
    method(:m17).should.be having_source(%(
      def m17; %w{\#{__FILE__}}; end
    ))
  end

  should 'not handle escaped-interpolation' do
    def m18; "\#{__FILE__}"; end
    method(:m18).should.be having_source(%(
      def m18; "\\\#{__FILE__}"; end
    ))
  end

  should 'not handle non-interpolated' do
    def m19; "__FILE__"; end
    method(:m19).should.be having_source(%(
      def m19; "__FILE__"; end
    ))
  end

end
