require 'rubygems'
require 'bacon'
require 'ruby_parser'
require 'ruby2ruby'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'to_source'

Bacon.summary_on_exit

def watever(*args, &block)
  Proc.new(&block)
end

def normalize_code(code)
  Ruby2Ruby.new.process(RubyParser.new.parse(code))
end

def having_same_code_as(expected)
  lambda {|_proc| normalize_code(_proc.to_source) == normalize_code(expected) }
end

