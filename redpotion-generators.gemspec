# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redpotion/generators/version'

Gem::Specification.new do |spec|
  spec.name          = "redpotion-generators"
  spec.version       = Redpotion::Generators::VERSION
  spec.authors       = ["Andrew Havens"]
  spec.email         = ["email@andrewhavens.com"]

  spec.summary       = %q{Additional command line generators for RedPotion.}
  spec.description   = %q{Additional command line generators for RedPotion. Adds scaffolding, form, and model generators.}
  spec.homepage      = "https://github.com/andrewhavens/redpotion-generators"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "activesupport", "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 2.4"
  spec.add_development_dependency "aruba", "~> 0.14.2"
end
