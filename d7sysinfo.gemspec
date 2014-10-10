# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'd7sysinfo/version'

Gem::Specification.new do |spec|
  spec.name          = "d7sysinfo"
  spec.version       = D7sysinfo::VERSION
  spec.authors       = ["Shane Davies"]
  spec.email         = ["shane@domain7.com"]
  spec.summary       = %q{Gem to help gather reporting information from chef nodes and other D7 systems.}
  spec.description   = %q{Gather basic server information, websites ssl certificates and os details.}
  spec.homepage      = "https://github.com/domain7/d7sysinfo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("ohai")
  spec.add_runtime_dependency("to_xml")

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("rspec-mocks")
  spec.add_development_dependency("pry")
end
