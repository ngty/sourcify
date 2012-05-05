require 'sorcerer'

module Sourcify
  class << self
    def require_rb(*files)
      @root ||= ::File.expand_path('../sourcify', __FILE__)
      [files].flatten.each{|f| require File.join(@root, f) }
    end
  end
end

Sourcify.require_rb(%w{version proc})
