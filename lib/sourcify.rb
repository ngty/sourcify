require 'rubygems'
require 'ruby2ruby'

begin
  require 'parse_tree'
  require 'parse_tree_extensions'
rescue LoadError
  require 'ruby_parser'
end

require 'sourcify/proc'
