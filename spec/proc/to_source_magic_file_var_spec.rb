require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source (magic var __FILE__)" do

  should 'handle single standalone' do
    lambda { __FILE__ }.should.be having_source(%(proc { "#{__FILE__}" }))
  end

  should 'handle multiple standalones' do
    lambda {
      [
        __FILE__, __FILE__,
        __FILE__
      ]
    }.should.be having_source(%Q(
      proc do
        [
          "#{__FILE__}", "#{__FILE__}",
          "#{__FILE__}"
        ]
      end
    ))
  end

  should 'handle single interpolation' do
    lambda { "#{__FILE__}" }.should.be having_source(%(proc { "#{__FILE__}" }))
  end

  should 'handle multiple interpolation (separate)' do
    lambda {
      [
        "#{__FILE__}", "#{__FILE__}",
        "#{__FILE__}"
      ]
    }.should.be having_source(%Q(
      proc do
        [
          "#{__FILE__}", "#{__FILE__}",
          "#{__FILE__}"
        ]
      end
    ))
  end

  should 'handle multiple interpolation (together)' do
    lambda {
      <<EOL
#{__FILE__}, #{__FILE__},
#{__FILE__}
EOL
    }.should.be having_source(%Q(
      proc do
        <<EOL
#{__FILE__}, #{__FILE__},
#{__FILE__}
EOL
      end
    ))
  end

  should 'handle interpolation in (") quoted string' do
    lambda { "#{__FILE__}" }.should.be having_source(%Q(proc { "#{__FILE__}" }))
  end

  should 'handle interpolation in (%) quoted string' do
    lambda { %(#{__FILE__}) }.should.be having_source(%Q(proc { "#{__FILE__}" }))
  end

  should 'handle interpolation in (%Q) quoted string' do
    lambda { %Q(#{__FILE__}) }.should.be having_source(%Q(proc { "#{__FILE__}" }))
  end

  should 'handle interpolation in heredoc string' do
    lambda {
      <<-EOL
#{__FILE__}
EOL
    }.should.be having_source(%Q(
      proc do
        <<-EOL
#{__FILE__}
EOL
      end
    ))
  end

  should 'handle interpolation in (%r) regexp' do
    lambda { %r(#{__FILE__}) }.should.be having_source(%Q(proc { %r(#{__FILE__}) }))
  end

  should 'handle interpolation in (/) regexp' do
    lambda { /#{__FILE__}/ }.should.be having_source(%Q(proc { %r(#{__FILE__}) }))
  end

  should 'handle interpolation in (%x) command' do
    lambda { %x(echo #{__FILE__}) }.should.be having_source(%Q(proc { %x(echo #{__FILE__}) }))
  end

  should 'handle interpolation in (`) command' do
    lambda { `echo #{__FILE__}` }.should.be having_source(%Q(proc { `echo #{__FILE__}` }))
  end

  should 'handle interpolation in (%W) array' do
    lambda { %W(#{__FILE__}) }.should.be having_source(%Q(proc { %W(#{__FILE__}) }))
  end

  should 'not handle interpolation in (\') quoted string' do
    lambda { '#{__FILE__}' }.should.be having_source(%Q(proc { '\#{__FILE__}' }))
  end

  should 'not handle interpolation in (%q) quoted string' do
    lambda { %q(#{__FILE__}) }.should.be having_source(%Q(proc { '\#{__FILE__}' }))
  end

  should 'not handle interpolation in (%w) array' do
    lambda { %w(#{__FILE__}) }.should.be having_source(%Q(proc { %w{\#{__FILE__}} }))
  end

  should 'not handle escaped-interpolation' do
    lambda { "\#{__FILE__}" }.should.be having_source('proc { "\#{__FILE__}" }')
  end

  should 'not handle non-interpolated' do
    lambda { "__FILE__" }.should.be having_source(%(proc { "__FILE__" }))
  end

end
