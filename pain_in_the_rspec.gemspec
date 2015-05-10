# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pain_in_the_rspec/version'

Gem::Specification.new do |spec|
  spec.name          = "pain_in_the_rspec"
  spec.version       = PainInTheRspec::VERSION
  spec.authors       = ["Gabe Berke-Williams"]
  spec.email         = ["gabebw@gabebw.com"]

  spec.summary       = %q{Print out punny spec descriptions}
  spec.homepage      = "https://github.com/gabebw/pain_in_the_rspec"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec-core", "~> 3.0"
  spec.add_dependency "girls_just_want_to_have_puns"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
