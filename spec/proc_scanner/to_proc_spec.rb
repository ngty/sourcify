require File.join(File.dirname(__FILE__), 'spec_helper')

describe "#to_proc" do

  should 'handle &:xxx' do
    process(" &:xxx ").should.include([:to_proc, '&:xxx'])
  end

  %w{&xxx :xxx}.each do |expr|
    should "handle not #{expr}" do
      process(" #{expr} ").map(&:first).should.not.include(:to_proc)
    end
  end

end
