require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

unless has_parsetree?
describe "Shash operator" do

  should 'handle w preceding variable' do
    process(%Q(a / b)).should.include([:op, '/'])
  end

  should 'handle w preceding constant' do
    process(%Q(A / b)).should.include([:op, '/'])
  end

  should 'handle w preceding symbol' do
    process(%Q(:a / b)).should.include([:op, '/'])
  end

  should 'handle w preceding digit' do
    process(%Q(0 / b)).should.include([:op, '/'])
  end

  should 'handle w preceding a~f' do
    process(%Q(0xa / b)).should.include([:op, '/'])
    process(%Q(0xb / b)).should.include([:op, '/'])
    process(%Q(0xc / b)).should.include([:op, '/'])
    process(%Q(0xd / b)).should.include([:op, '/'])
    process(%Q(0xe / b)).should.include([:op, '/'])
    process(%Q(0xf / b)).should.include([:op, '/'])
  end

  should 'handle w preceding dstring' do
    process(%Q("a" / b)).should.include([:op, '/'])
  end

  should 'handle w preceding sstring' do
    process(%Q('a' / b)).should.include([:op, '/'])
  end

  should "handle w preceding ')' char" do
    process(%Q{) / b}).should.include([:op, '/'])

  end

  should "handle w preceding ']' char" do
    process(%Q(] / b)).should.include([:op, '/'])
  end

  should "handle w preceding '}' char" do
    process(%Q(} / b)).should.include([:op, '/'])
  end

  should "not handle w preceding newline" do
    process(%Q(
      / b /
    )).should.not.include([:op, '/'])
  end

  should "not handle w preceding ';' char" do
    process(%Q(; / b /)).should.not.include([:op, '/'])
  end

  should "not handle w preceding '(' char" do
    process(%Q{( / b /}).should.not.include([:op, '/'])
  end

  should "not handle w preceding '{' char" do
    process(%Q({ / b /)).should.not.include([:op, '/'])
  end

  should "not handle w preceding '[' char" do
    process(%Q([ / b /)).should.not.include([:op, '/'])
  end

end
end
