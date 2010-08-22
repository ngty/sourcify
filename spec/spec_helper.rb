require 'rubygems'
require 'bacon'
require 'ruby2ruby'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'to_source'

Bacon.summary_on_exit

def watever(*args, &block)
  Proc.new(&block)
end

def code_to_sexp(code)
  if Object.const_defined?(:ParseTree)
    require 'parse_tree'
    Unifier.new.process(ParseTree.translate(code))
  else
    require 'ruby_parser'
    RubyParser.new.parse(code)
  end
end

def normalize_code(code)
  Ruby2Ruby.new.process(code_to_sexp(code))
end

def having_code(expected)
  lambda {|_proc| normalize_code(_proc.to_source) == normalize_code(expected) }
end

def having_sexp(expected)
  lambda {|_proc| _proc.to_sexp.inspect == expected.inspect }
end

