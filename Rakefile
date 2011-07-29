require 'rubygems'
require 'rake'
require 'bundler'
Bundler::GemHelper.install_tasks

SPEC_SCRIPT = File.expand_path('../spec/run_spec.sh', __FILE__)
task :default => :spec

RUBIES = {
  :parsetree => [
    'ruby-1.8.6-p420@sourcify-parsetree',
    'ruby-1.8.7-p334@sourcify-parsetree',
    'ree-1.8.7-2011.03@sourcify-parsetree'
  ],
  :static => [
    [nil, 'ruby-1.8.6-p420@sourcify'],
    [nil, 'ruby-1.8.7-p334@sourcify'],
    [nil, 'ree-1.8.7-2011.03@sourcify'],
    [nil, 'jruby-1.6.3@sourcify'],
    [nil, 'ruby-1.9.1-p378@sourcify'],
    [nil, 'ruby-1.9.2-p290@sourcify'],

    # NOTE: This doesn't work yet due to jruby's Method#parameters bug,
    # see http://jira.codehaus.org/browse/JRUBY-5954
    #['JRUBY_OPTS="--1.9"', 'jruby-1.6.3@sourcify'],
  ]
}

# ///////////////////////////////////////////////////////////
# Running Specs
# ///////////////////////////////////////////////////////////
desc "Run all specs"
task :spec do |t|
  system SPEC_SCRIPT
end

desc "Run specs in all rubies (both ParseTree & static scanner modes)"
task :'spec:all' do
  system 'export MUTE_BACON=true; rvm ' +
    RUBIES.values.flatten.join(',') + ' exec ' + SPEC_SCRIPT
end

desc "Run specs in rubies supporting ParseTree mode"
task :'spec:parsetree' do
  system 'export MUTE_BACON=true; rvm ' +
    RUBIES[:parsetree].join(',') + ' exec ' + SPEC_SCRIPT
end

desc "Run specs in rubies supporting static scanner mode"
task :'spec:static' do
  rubies_wo_env = RUBIES[:static].map{|env,ruby| env ? nil : ruby }.compact
  rubies_w_env = RUBIES[:static].select{|env,ruby| env }

  system 'export MUTE_BACON=true; rvm ' +
    rubies_wo_env.join(',') + ' exec ' + SPEC_SCRIPT

  rubies_w_env.each do |env, rubi|
    system "export MUTE_BACON=true; export #{env}; rvm #{rubi} exec #{SPEC_SCRIPT}"
  end
end

# ///////////////////////////////////////////////////////////
# Build ruby files from ragel definitions
# ///////////////////////////////////////////////////////////
desc "Run ragel to generate ruby scanner files from ragel definitions"
task :ragel do
  %w{method proc}.each do |m|
    common_dir = File.expand_path('../lib/sourcify/common/ragel', __FILE__)
    ragel_dir = File.expand_path("../lib/sourcify/#{m}/parser", __FILE__)
    ragel_file = File.join(ragel_dir, 'raw_scanner.rl')
    ruby_file = File.join(ragel_dir, 'raw_scanner.rb')
    File.delete(ruby_file) rescue nil
    puts 'Processing %s -> %s' %
      [ragel_file, ruby_file].map{|f| f.sub(File.expand_path('../', __FILE__) + '/', '')}
    system("ragel -I #{common_dir} -R #{ragel_file}")
  end
end

# ///////////////////////////////////////////////////////////
# Benchmarking
# ///////////////////////////////////////////////////////////
desc "Benchmarking"
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

