require 'rubygems'
require 'ruby2ruby'

begin
  require 'parse_tree'
  require 'parse_tree_extensions'
rescue LoadError
  require 'ruby_parser'
  require 'sexp_processor'
  require 'file/tail'
end

module Sourcify

  ROOT = File.dirname(File.expand_path(__FILE__))

  class << self
    def require_rb(*args)
      require File.join(ROOT, 'sourcify', *args)
    end
  end

end

require 'sourcify/proc'
