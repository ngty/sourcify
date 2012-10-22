require 'rubygems'
require 'ruby_parser'
require 'sexp_processor'
require 'ruby2ruby'
require 'file/tail'

begin
  require 'parse_tree'
  require 'parse_tree_extensions'
rescue LoadError
  # ParseTree is now optional for all supported rubies :)
end

module Sourcify #:nodoc:

  IS_19x = RUBY_VERSION.include?('1.9.')

  HAS_RIPPER =
    begin
      require 'ripper'
      true
    rescue LoadError
      false
    end

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

Sourcify.require_rb('patches')
Sourcify.require_rb('errors')
Sourcify.require_rb('version')
Sourcify.require_rb('proc')
Sourcify.require_rb('method')
