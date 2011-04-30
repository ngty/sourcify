require 'rubygems'
require 'rake'
require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :spec

# Running Specs
desc "Run all specs"
task :spec do |t|
  system 'bacon spec/**/*_spec.rb'
end

# Benchmarking
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

