# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/azurjp/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-azurjp"
  spec.version       = Ruboty::Azurjp::VERSION
  spec.authors       = ["Shulla Cignoir"]
  spec.email         = ["cignoir@gmail.com"]

  spec.summary       = %q{azurlane helper}
  spec.description   = %q{azurlane helper}
  spec.homepage      = "http://github.com/cignoir/azurjp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'open-uri'
  spec.add_dependency 'terminal-table'
end
