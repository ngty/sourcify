require 'rubygems'
require 'bacon'
require 'ruby2ruby'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sourcify'

ragel_dir = File.join(File.dirname(__FILE__), '..', 'lib', 'sourcify', 'proc')
ragel_file = File.join(ragel_dir, 'scanner.rl')
ruby_file = File.join(ragel_dir, 'scanner.rb')
File.delete(ruby_file) rescue nil
system("ragel -R #{ragel_file}")

begin
  require File.join(ragel_dir, 'scanner.rb')
rescue LoadError
  raise $!
end

Bacon.summary_on_exit

def has_parsetree?
  Object.const_defined?(:ParseTree)
end

def watever(*args, &block)
  Proc.new(&block)
end

def code_to_sexp(code)
  if has_parsetree?
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

def having_source(expected)
  lambda do |_proc|
    normalize_code(_proc.to_source) == normalize_code(expected)
  end
end

def having_sexp(expected)
  lambda do |_proc|
    expected = eval(expected) if expected.is_a?(String)
    _proc.to_sexp.inspect == expected.inspect
  end
end

def capture(stdin_str = '')
  begin
    require 'stringio'
    $o_stdin, $o_stdout, $o_stderr = $stdin, $stdout, $stderr
    $stdin, $stdout, $stderr = StringIO.new(stdin_str), StringIO.new, StringIO.new
    yield
    {:stdout => $stdout.string, :stderr => $stderr.string}
  ensure
    $stdin, $stdout, $stderr = $o_stdin, $o_stdout, $o_stderr
  end
end
