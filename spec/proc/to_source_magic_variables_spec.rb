require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source (magic variables)" do

  describe '>> __FILE__' do

    should 'handle standalone' do
      lambda { __FILE__ }.should.be having_source(%|proc { "#{__FILE__}" }|)
    end

    should 'handle embedded in string' do
      lambda { "#{__FILE__}" }.should.be having_source(%|proc { "#{__FILE__}" }|)
    end

    should 'handle embedded in heredoc' do
      lambda {
        <<EOL
  #{__FILE__}
EOL
      }.should.be having_source(%|proc { "  #{__FILE__}\n" }|)
    end

    should 'not handle non-embedded in string' do
      lambda { "__FILE__" }.should.be having_source(%|proc { "__FILE__" }|)
    end

    should 'not handle non-embedded in heredoc' do
      lambda {
        <<EOL
  __FILE__
EOL
      }.should.be having_source(%|proc { "  __FILE__\n" }|)
    end

  end

  describe '>> __LINE__' do

    should 'handle single standalone' do
      lambda { __LINE__ }.should.be having_source(%|proc { #{__LINE__} }|)
    end

    should 'handle multiple standalones' do
      lambda {
        [
          __LINE__,
          __LINE__
        ]
      }.should.be having_source(%|proc { [#{__LINE__ - 3}, #{__LINE__ - 2}] }|)
    end

    should 'handle single embedded' do
      lambda { "#{__LINE__}" }.should.be having_source(%|proc { "\#{#{__LINE__}}" }|)
    end

    should 'handle single embedded (heredoc)' do
      lambda {
        <<EOL
  #{__LINE__}
EOL
      }.should.be having_source(%|proc { "  \#{#{__LINE__ - 2}}\n" }|)
    end

    should 'handle multiple embedded' do
      lambda {
        [
          "#{__LINE__}",
          "#{__LINE__}"
        ]
      }.should.be having_source(%|proc { ["\#{#{__LINE__ - 3}}", "\#{#{__LINE__ - 2}}"] }|)
    end

    should 'handle multiple embedded (heredoc)' do
      lambda {
        <<EOL
  #{__LINE__}
  #{__LINE__}
EOL
      }.should.be having_source(%|proc { "  \#{#{__LINE__ - 3}}\n  \#{#{__LINE__ - 2}}\n" }|)
    end

    should 'not handle non-embedded in string' do
      lambda { "__LINE__" }.should.be having_source(%|proc { "__LINE__" }|)
    end

    should 'not handle non-embedded in heredoc' do
      lambda {
        <<-EOL
  __LINE__
EOL
      }.should.be having_source(%|proc { "  __LINE__\n" }|)
    end

  end

end
