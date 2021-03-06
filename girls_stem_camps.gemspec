# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'girls_stem_camps/version'

Gem::Specification.new do |spec|
  spec.name          = "girls_stem_camps"
  spec.version       = GirlsStemCamps::VERSION
  spec.authors       = ["jmheyd"]
  spec.email         = ["heydjm@comcast.net"]

  spec.summary       = %q{List some summer STEM camps for high school girls.}
  spec.description   = %q{User can get more information regarding price and dates.}
  spec.homepage      = "https://github.com/jmheyd/girls-stem-camps-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
   # spec.metadata['allowed_push_host'] = "https://rubygems.org"
  #else
   # raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 0'
  spec.add_development_dependency 'pry', '~> 0'

  spec.add_dependency 'nokogiri'
end
