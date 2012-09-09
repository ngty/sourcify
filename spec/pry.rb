#!/usr/bin/env ruby
require 'pry'
require 'stringio'

input = StringIO.new([ARGV[0], 'exit'].join("\n"))
Pry.start(5, :input => input)
