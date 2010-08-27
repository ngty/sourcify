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
      lambda { __LINE__ }.should.be having_source(%Q|
        proc do
          #{__LINE__ - 2}
        end
      |)
    end

    should 'handle multiple standalones' do
      lambda {
        [
          __LINE__, __LINE__,
          __LINE__
        ]
      }.should.be having_source(%Q|
        proc do
          [
            #{__LINE__ - 6}, #{__LINE__ - 6},
            #{__LINE__ - 6}
          ]
        end
      |)
    end

    should 'handle single embedded' do
      lambda { "#{__LINE__}" }.should.be having_source(%|proc { "\#{#{__LINE__}}" }|)
    end

    should 'handle multiple embedded' do
      lambda {
        [
          "#{__LINE__}", "#{__LINE__}",
          "#{__LINE__}"
        ]
      }.should.be having_source(%Q|
        proc do
          [
            "\#{#{__LINE__ - 6}}", "\#{#{__LINE__ - 6}}",
            "\#{#{__LINE__ - 6}}"
          ]
        end
      |)
    end

    should 'handle single embedded (heredoc)' do
      lambda {
        <<EOL
  #{__LINE__}
EOL
      }.should.be having_source(%Q|
        proc do
          "  \#{#{__LINE__ - 4}}\n"
        end
      |)
    end

    should 'handle multiple embedded (heredoc)' do
      lambda {
        <<EOL
  #{__LINE__}, #{__LINE__},
  #{__LINE__}
EOL
      }.should.be having_source(%Q|
        proc do
          <<EOL
  \#{#{__LINE__ - 6}}, \#{#{__LINE__ - 6}},
  \#{#{__LINE__ - 6}}
EOL
        end
      |)
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
