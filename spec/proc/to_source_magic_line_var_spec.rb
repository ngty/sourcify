require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source (magic var __LINE__)" do

  should 'handle single standalone' do
    lambda { __LINE__ }.should.be having_source(%(proc { #{__LINE__} }))
  end

  should 'handle multiple standalones' do
    lambda {
      [
        __LINE__, __LINE__,
        __LINE__
      ]
    }.should.be having_source(%Q(
      proc do
        [
          #{__LINE__ - 6}, #{__LINE__ - 6},
          #{__LINE__ - 6}
        ]
      end
    ))
  end

  should 'handle single interpolation' do
    lambda { "#{__LINE__}" }.should.be having_source(%(proc { "\#{#{__LINE__}}" }))
  end

  should 'handle multiple interpolation (separate)' do
    lambda {
      [
        "#{__LINE__}", "#{__LINE__}",
        "#{__LINE__}"
      ]
    }.should.be having_source(%Q(
      proc do
        [
          "\#{#{__LINE__ - 6}}", "\#{#{__LINE__ - 6}}",
          "\#{#{__LINE__ - 6}}"
        ]
      end
    ))
  end

  should 'handle multiple interpolation (together)' do
    lambda {
      <<EOL
#{__LINE__}, #{__LINE__},
#{__LINE__}
EOL
    }.should.be having_source(%Q(
      proc do
        <<EOL
\#{#{__LINE__ - 6}}, \#{#{__LINE__ - 6}},
\#{#{__LINE__ - 6}}
EOL
      end
    ))
  end

  should 'handle interpolation in (") quoted string' do
    lambda { "#{__LINE__}" }.should.be having_source(%Q(proc { "\#{#{__LINE__}}" }))
  end

  should 'handle interpolation in (%) quoted string' do
    lambda { %(#{__LINE__}) }.should.be having_source(%Q(proc { "\#{#{__LINE__}}" }))
  end

  should 'handle interpolation in (%Q) quoted string' do
    lambda { %Q(#{__LINE__}) }.should.be having_source(%Q(proc { "\#{#{__LINE__}}" }))
  end

  should 'handle interpolation in heredoc string' do
    lambda {
      <<-EOL
#{__LINE__}
EOL
    }.should.be having_source(%Q(
      proc do
        <<-EOL
\#{#{__LINE__ - 5}}
EOL
      end
    ))
  end

  should 'handle interpolation in (%r) regexp' do
    lambda { %r(#{__LINE__}) }.should.be having_source(%Q(proc { %r(\#{#{__LINE__}}) }))
  end

  should 'handle interpolation in (/) regexp' do
    lambda { /#{__LINE__}/ }.should.be having_source(%Q(proc { %r(\#{#{__LINE__}}) }))
  end

  should 'handle interpolation in (%x) command' do
    lambda { %x(echo #{__LINE__}) }.should.be having_source(%Q(proc { %x(echo \#{#{__LINE__}}) }))
  end

  should 'handle interpolation in (`) command' do
    lambda { `echo #{__LINE__}` }.should.be having_source(%Q(proc { `echo \#{#{__LINE__}}` }))
  end

  should 'handle interpolation in (%W) array' do
    lambda { %W(#{__LINE__}) }.should.be having_source(%Q(proc { %W(\#{#{__LINE__}}) }))
  end

  should 'not handle interpolation in (\') quoted string' do
    lambda { '#{__LINE__}' }.should.be having_source(%Q(proc { '\#{__LINE__}' }))
  end

  should 'not handle interpolation in (%q) quoted string' do
    lambda { %q(#{__LINE__}) }.should.be having_source(%Q(proc { '\#{__LINE__}' }))
  end

  should 'not handle interpolation in (%w) array' do
    lambda { %w(#{__LINE__}) }.should.be having_source(%Q(proc { %w{\#{__LINE__}} }))
  end

  should 'not handle escaped-interpolation' do
    lambda { "\#{__LINE__}" }.should.be having_source('proc { "\#{__LINE__}" }')
  end

  should 'not handle non-interpolated' do
    lambda { "__LINE__" }.should.be having_source(%(proc { "__LINE__" }))
  end

end
