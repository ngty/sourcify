require 'rubygems'
require 'ruby2ruby'

begin
  require 'parse_tree'
  require 'parse_tree_extensions'
rescue LoadError
  require 'ruby_parser'
  require 'file/tail'
end

require 'sourcify/proc'
