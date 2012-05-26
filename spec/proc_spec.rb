require File.expand_path('../spec_helper', __FILE__)

describe Proc do
  extend Sourcify::SpecHelper

  describe '#to_source' do
    it 'must return instance of Sourcify::Proc::Source' do
      Proc.new { :thing }.to_source.
        must_be_instance_of(Sourcify::Proc::Source)
    end
  end

end
