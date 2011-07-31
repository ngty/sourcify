require File.expand_path('../../spec_helper', __FILE__)

describe "Unsupported Platform" do

  thing = Class.new do
    def self.echo
    end
  end

  should 'raise Sourcify::PlatformNotSupportedError when calling Method#to_source' do
    lambda{ thing.method(:echo).to_source }.should.
      raise(Sourcify::PlatformNotSupportedError)
  end

  should 'raise Sourcify::PlatformNotSupportedError when calling Method#to_sexp' do
    lambda{ thing.method(:echo).to_sexp }.should.
      raise(Sourcify::PlatformNotSupportedError)
  end

  should 'raise Sourcify::PlatformNotSupportedError when calling Method#to_raw_source' do
    lambda{ thing.method(:echo).to_raw_source }.should.
      raise(Sourcify::PlatformNotSupportedError)
  end

end

