# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blue_print/version'

Gem::Specification.new do |spec|
  spec.name          = 'blue_print'
  spec.version       = BluePrint::VERSION
  spec.authors       = ['Sho Kusano']
  spec.email         = ['rosylilly@aduca.org']
  spec.summary       = %q{The behavior switching framework for Rails}
  spec.homepage      = 'http://magnet-inc.github.io/blue_print'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-console'
  spec.add_development_dependency 'rails', '>= 3.1'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'generator_spec'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'draper'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'hashie'
  spec.add_dependency 'thread-parent'
end
