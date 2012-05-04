# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sourcify/version"

Gem::Specification.new do |s|
  s.name        = "sourcify"
  s.version     = Sourcify::VERSION
  s.authors     = ["NgTzeYang"]
  s.email       = ["ngty@gmail.com"]
  s.homepage    = "http://github.com/ngty/sourcify"
  s.summary     = %q{Workarounds before ruby-core officially supports Proc#to_source (& friends)}
  s.description = %q{}

  s.add_dependency 'sorcerer', '~> 0.0.7'

  # TODO: Fix shelling out to run "git ls-files" !!
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
