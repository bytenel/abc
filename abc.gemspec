# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'abc/version'

Gem::Specification.new do |spec|
  spec.name          = "abc"
  spec.version       = Abc::VERSION
  spec.authors       = ["Ben Nelson"]
  spec.email         = ["nelson.ben.c@gmail.com"]
  spec.summary       = %q{ Formats Gemfiles into alphabetical order. }
  spec.homepage      = "http://www.illegalnumbers.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
