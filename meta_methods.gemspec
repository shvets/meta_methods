# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/lib/meta_methods/version')

Gem::Specification.new do |spec|
  spec.name          = "meta_methods"
  spec.summary       = %q{Collection of methods for easing meta-programming}
  spec.description   = %q{Collection of methods for easing meta-programming}
  spec.email         = "alexander.shvets@gmail.com"
  spec.authors       = ["Alexander Shvets"]
  spec.homepage      = "http://github.com/shvets/meta_methods"

  spec.files         = `git ls-files`.split($\)
  #spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  #gemspec.bindir = "bin"
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.version       = MetaMethods::VERSION
  #gemspec.requirements = ["none"]

  spec.add_development_dependency "gemspec_deps_gen", [">= 0"]
  spec.add_development_dependency "gemcutter", [">= 0"]
  
end

