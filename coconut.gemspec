# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coconut/version'

Gem::Specification.new do |gem|
  gem.name          = "coconut"
  gem.version       = Coconut::VERSION
  gem.authors       = ["Javier Acero"]
  gem.email         = ["javier@path11.com"]
  gem.description   = %q{A coconfiguration tool for your Ruby applications }
  gem.summary       = %q{Coconut is a simple DSL that allows you to easily write and query your application's configuration with pure Ruby.}
  gem.homepage      = "http://github.com/jacegu/coconut"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'hashie'

  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
