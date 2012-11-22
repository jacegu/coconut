# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coconut/version'

Gem::Specification.new do |gem|
  gem.name          = "coconut"
  gem.version       = Coconut::VERSION
  gem.authors       = ["Javier Acero"]
  gem.email         = ["javier@path11.com"]
  gem.description   = %q{A co-configuration tool for your Ruby projects}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
