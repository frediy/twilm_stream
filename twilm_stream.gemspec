# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twilm_stream/version'

Gem::Specification.new do |spec|
  spec.name          = "twilm_stream"
  spec.version       = TwilmStream::VERSION
  spec.authors       = ["Fredrik Persen Fostvedt"]
  spec.email         = ["fpfostvedt@gmail.com"]
  spec.description   = %q{Twilm harvests tweets and user data related to movies from twitter stream api}
  spec.summary       = %q{Twilm harvests twitter streams for movies}
  spec.homepage      = "http://github.com/theminted/twilm_stream"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
