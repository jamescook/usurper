# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "usurper"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Cook"]
  s.email       = ["james@james.com"]
  s.summary     = %q{usurper}

  s.required_ruby_version     = '>= 2.1.0'
  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency "rspec"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths      = ["lib"]
end
