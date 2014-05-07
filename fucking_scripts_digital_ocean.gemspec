# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fucking_scripts_digital_ocean/version'

Gem::Specification.new do |spec|
  spec.name          = "fucking_scripts_digital_ocean"
  spec.version       = FuckingScriptsDigitalOcean::VERSION
  spec.authors       = ["Phuong Gia Su", "Brandon Hilkert"]
  spec.email         = ["phuongnd08@gmail.com", "brandonhilkert@gmail.com"]
  spec.description   = %q{The easiest, most common sense configuration management tool... because you just use fucking simple scripts.}
  spec.summary       = %q{The easiest, most common sense configuration management tool... because you just use fucking simple scripts.}
  spec.homepage      = "https://github.com/phuongnd08/fucking_scripts_digital_ocean"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "fog", "~> 1.14.0"
end
