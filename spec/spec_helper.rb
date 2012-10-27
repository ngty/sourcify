require 'rubygems'
require 'ruby_parser'
require 'ruby2ruby'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sourcify'

# ///////////////////////////////////////////////////////////
# Bacon
# ///////////////////////////////////////////////////////////

require 'bacon'
Bacon.extend(Bacon::TestUnitOutput)
Bacon.summary_on_exit

# Removing the extra noises in output, making bacon even less verbose !!
if ENV['MUTE_BACON'] == 'true'
  Bacon.extend(Module.new {

    def handle_requirement(description)
      unless (error = yield).empty?
        print error[0..0]
      end
    end

    def handle_summary
      puts "", "  %d tests, %d assertions, %d failures, %d errors" %
        Bacon::Counter.values_at(:specifications, :requirements, :failed, :errors)
    end

  })
end

# ///////////////////////////////////////////////////////////
# Spec helpers & matchers
# ///////////////////////////////////////////////////////////

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

def having_source(expected, opts={}, &matcher)
  lambda do |thing|
    #normalize_code(expected) # added for bug fixing
    normalize_code(block_given? ? thing.to_source(&matcher) : thing.to_source(opts)) \
      == normalize_code(expected)
  end
end

def having_raw_source(expected, opts={}, &matcher)
  lambda do |thing|
    found = block_given? ? thing.to_raw_source(&matcher) : thing.to_raw_source(opts)
    found == expected.strip
  end
end

def having_sexp(expected, opts={}, &matcher)
  lambda do |thing|
    expected = eval(expected) if expected.is_a?(String)
    if block_given?
      thing.to_sexp(&matcher).inspect == expected.inspect
    else
      thing.to_sexp(opts).inspect == expected.inspect
    end
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

def irb_exec(stdin_str)
  # See http://tyenglog.heroku.com/2010/9/how-to-test-irb-specific-support &
  # http://tyenglog.heroku.com/2010/9/how-to-test-irb-specific-support-2-
  sourcify_rb = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'sourcify.rb')
  irb_feedback = /^ ?=> /
  irb_opts = '--simple-prompt'
  values = %x(echo "#{stdin_str}" | irb #{irb_opts} -r #{sourcify_rb}).split("\n").
    grep(irb_feedback).map{|s| eval(s.sub(irb_feedback,'').strip) }

  # IRB behaves slightly differently in 1.9.2 for appending newline
  (values[-1].nil? && RUBY_VERSION =~ /1.9.(2|3)/) ? values[0 .. -2] : values
end

def pry_exec(stdin_str)
  sourcify_rb = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'sourcify.rb')
  pry_opts = '--simple-prompt --no-color'
  results = []

  %x(echo "#{stdin_str}" | pry #{pry_opts} -r #{sourcify_rb}).
    split("\n").each do |line|
      case line
      when /^((?:>> |)=> )/
        results << [line.sub($1,'')]
      when /^( )/
        results[-1] << line
      end
    end

  results = results.map{|lines| eval(lines.join) }
  results[-1].nil? ? results[0..-2] : results
end

