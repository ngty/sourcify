require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (wo nesting complication)" do

  expected = 'proc { @x%s }'

  should 'handle watever(..) do ... end' do
    (
      watever(:a, :b, {:c => 1}) do @x1 end
    ).should.be having_source(expected%1)
  end

  should 'handle watever(..) \ do ... end' do
    (
      watever(:a, :b, {:c => 1}) \
        do @x2 end
    ).should.be having_source(expected%2)
  end

  should 'handle watever do ... end' do
    (
      watever do @x3 end
    ).should.be having_source(expected%3)
  end

  should 'handle watever \ do ... end' do
    (
      watever \
        do @x4 end
    ).should.be having_source(expected%4)
  end

  should 'handle lambda do ... end' do
    (
      lambda do @x5 end
    ).should.be having_source(expected%5)
  end

  should 'handle lambda \ do ... end' do
    (
      lambda \
        do @x6 end
    ).should.be having_source(expected%6)
  end

end
