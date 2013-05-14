# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/xctool-test/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-xctool-test"
  spec.version       = Guard::XctoolTestVersion::VERSION
  spec.authors       = ["Francis Chong"]
  spec.email         = ["francis@ignition.hk"]
  spec.description   = %q{Xctool test guard allows you to automically & intelligently aunch specs when files are modified. This gem use xctool to build and run tests, and xcodeproj gem to parse project file.}
  spec.summary       = %q{Xctool test guard allows you to automically & intelligently aunch specs when files are modified.}
  spec.homepage      = "https://github.com/siuying/guard-xctool-test"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency "guard"
  spec.add_dependency "xcodeproj"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
