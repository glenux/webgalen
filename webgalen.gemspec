# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webgalen/version'

Gem::Specification.new do |spec|
  spec.name          = "webgalen"
  spec.version       = Webgalen::VERSION
  spec.authors       = ["Glenn Y. Rolland"]
  spec.email         = ["glenux@glenux.net"]
  spec.summary       = %q{Use GIT logs to give an estimation of spent time & costs of your projects.}
  spec.description   = %q{Use GIT logs to give an estimation of spent time & costs of your projects.}
  spec.homepage      = "https://github.com/glenux/webgalen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "table_print", "~> 1.5"
  spec.add_runtime_dependency "mechanize", "~> 2.7"
  spec.add_runtime_dependency "selenium-webdriver", "~> 3.14"
  spec.add_runtime_dependency 'colorize', '~> 0.8.1'
  spec.add_runtime_dependency 'celluloid', '~> 0.17.3'
  spec.add_runtime_dependency 'thor', '~> 0.20.0'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end

