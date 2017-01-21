# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'photomontage/version'

Gem::Specification.new do |spec|
  spec.name          = "photomontage"
  spec.version       = Photomontage::VERSION
  spec.authors       = ["Aishwarya"]
  spec.email         = ["aishwarya923@gmail.com"]
  spec.summary       = %q{Photomontage - collage made from user provided keywords}
  spec.description   = %q{It's beautiful}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["photomontage"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"

  spec.add_runtime_dependency "httparty", ['0.14.0']
  spec.add_runtime_dependency "rmagick", ['2.16.0']
  spec.add_runtime_dependency "mini_magick", ['4.6.0']
  spec.add_runtime_dependency "ruby-progressbar", ['1.8.1']
  spec.add_runtime_dependency "colorize", ['0.8.1']
  spec.add_runtime_dependency "safe_yaml", ['1.0.4']
end
