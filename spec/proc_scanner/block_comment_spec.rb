require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

unless has_parsetree?
describe "Block comment (=begin ... =end)" do

  should 'handle =begin\n ... =end\n' do
    process(<<EOL
aa
=begin
 bb 
=end
cc
EOL
           ).should.include([:comment, "\n=begin\n bb \n=end"])
  end

  should 'handle =begin \n ... =end\n' do
    process(<<EOL
aa
=begin 
 bb 
=end
cc
EOL
           ).should.include([:comment, "\n=begin \n bb \n=end"])
  end

  should 'handle =begin aa \n ... =end\n' do
    process(<<EOL

=begin aa 
 bb 
=end
cc
EOL
           ).should.include([:comment, "\n=begin aa \n bb \n=end"])
  end

  should 'handle =begin\n ... =end \n' do
    process(<<EOL
aa
=begin
 bb 
=end 
cc
EOL
           ).should.include([:comment, "\n=begin\n bb \n=end "])
  end

  should 'not handle =begin\n ... =end ... \n' do
    process(<<EOL
aa
=begin
 bb 
=end cc
EOL
           ).should.not.include([:comment, "\n=begin\n bb \n=end cc"])
  end

end
end
