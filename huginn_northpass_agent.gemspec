# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
Gem::Specification.new do |spec|
  spec.name          = "huginn_northpass_agent"
  spec.version       = '0.1'
  spec.authors       = ["Paweł Cieśliński"]
  spec.email         = ["pawel.cieslinski@northpass.com"]
  spec.summary       = %q{A collection of huginn agents specially created to automate work with the Northpass platform.}
  spec.description   = %q{A collection of huginn agents specially created to automate work with the Northpass platform.}
  spec.homepage      = "https://github.com/SchoolKeep/huginn_northpass_agent"
  spec.license       = "MIT"
  spec.files         = Dir['LICENSE.txt', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*.rb'].reject { |f| f[%r{^spec/huginn}] }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "rails_helper"
  spec.add_development_dependency "pry-byebug"
  spec.add_runtime_dependency "huginn_agent"
end
