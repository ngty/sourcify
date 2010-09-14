require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.name = "sourcify"
    gem.summary = %Q{Workarounds before ruby-core officially supports Proc#to_source (& friends)}
    gem.description = %Q{}
    gem.email = "ngty77@gmail.com"
    gem.homepage = "http://github.com/ngty/sourcify"
    gem.authors = ["NgTzeYang"]
    gem.add_dependency 'ruby2ruby', '>= 1.2.5'
    gem.add_development_dependency "bacon", ">= 0"
    # Plus one of the following groups:
    #
    # 1). ParseTree (better performance + dynamic goodness, but not supported on java & 1.9.*)
    # >> gem.add_dependency "ParseTree", ">= 3.0.6"
    #
    # 2). RubyParser (supported for all)
    # >> gem.add_dependency "ruby_parser", ">= 2.0.5"
    # >> gem.add_dependency "sexp_processor", ">= 3.0.5"
    # >> gem.add_dependency "file-tail", ">= 1.0.5"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |spec|
    spec.libs << 'spec'
    spec.pattern = 'spec/**/*_spec.rb'
    spec.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :spec => :check_dependencies

begin
  require 'reek/adapters/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sourcify #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Benchmarking
task :benchmark, :task, :times do |t, args|
  times, task = (args.times || 5).to_i.method(:times), args.task
  title = " ~ Benchmark Results for Task :#{task} ~ "
  results = [%w{nth}, %w{user}, %w{system}, %w{total}, %w{real}]

  # Running benchmarking & collecting results
  require 'benchmark'
  times.call do |i|
    result = Benchmark.measure{ Rake::Task[task].execute }.to_s
    user, system, total, real =
      result.match(/^\s*(\d+\.\d+)\s+(\d+\.\d+)\s+(\d+\.\d+)\s+\(\s*(\d+\.\d+)\)$/)[1..-1]
    ["##{i.succ}", user, system, total, real].each_with_index{|val, j| results[j] << val }
  end

  # Formatting benchmarking results
  formatted_results = results.map do |rs|
    width = rs.map(&:to_s).map(&:size).max
    rs.map{|r| '  ' + r.ljust(width, ' ') }
  end.transpose.map{|row| row.join }

  # Showdown .. printout
  line = '=' * ([title.size, formatted_results.map(&:size).max].max + 2)
  puts [line, title, formatted_results.join("\n"), line].join("\n\n")

end
