require 'rubygems'
require 'ruby2ruby'
require 'sexp_processor'
require 'ruby_parser'
require 'file/tail'

begin
  require 'parse_tree'
  require 'parse_tree_extensions'
rescue LoadError
  # ParseTree is now optional for all supported rubies :)
end

module Sourcify #:nodoc:
  class << self

    def require_rb(*args)
      require root(*args)
    end

    def root(*args)
      @root ||= File.join(File.dirname(File.expand_path(__FILE__)), 'sourcify')
      File.join(@root, *args)
    end

  end
end

Sourcify.require_rb('facets')
Sourcify.require_rb('version')
Sourcify.require_rb('proc')
