require File.join(File.dirname(__FILE__), 'spec_helper')

describe "Per line comment (# ...)" do

  should 'handle start of line' do
    process(<<EOL
aa
# bb
cc
EOL
           ).should.include([:comment, '# bb'])
  end

  should 'handle middle of line' do
    process(<<EOL
aa # bb
cc
EOL
           ).should.include([:comment, '# bb'])
  end

  should 'ignore within heredoc' do
    process(<<EOL
            s <<eol
aa
# bb
cc
eol
EOL
           ).should.not.include([:comment, '# bb'])

  end

end
