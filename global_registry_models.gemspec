# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'global_registry_models/version'

Gem::Specification.new do |spec|
  spec.name          = 'global_registry_models'
  spec.version       = GlobalRegistryModels::VERSION
  spec.authors       = ['Sheldon Dueck']
  spec.email         = ['sheldon.dueck@gmail.com']

  spec.summary       = %q{Data models for the Global Registry.}
  spec.description   = %q{Provides data models for interacting with the Global Registry. Built ontop of the client gem global_registry.}
  spec.homepage      = 'https://github.com/sheldond/global_registry_models'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel', '~> 4.2.4'
  spec.add_dependency 'virtus', '~> 1.0.5'
  spec.add_dependency 'global_registry', '~> 1.0.7'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'pry'
end
