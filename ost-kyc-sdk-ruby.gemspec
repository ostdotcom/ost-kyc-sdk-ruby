# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kyc-sdk-ruby/version'

Gem::Specification.new do |spec|

  spec.name          = "kyc-sdk-ruby"
  spec.version       = KYCSdk::VERSION
  spec.authors       = ['OST']
  spec.email         = []
  spec.summary       = 'KYC Ruby SDK'
  spec.description   = 'KYC Ruby SDK provides easy integration with https://kyc.ost.com, the API for OST KYC.'
  spec.homepage      = "https://kyc.ost.com"
  spec.license       = "MIT"
  spec.metadata      = {
                        "documentation_uri" => "https://dev.ost.com/docs/kyc/index.html"
                      }

  spec.files         = Dir['{lib}/**/*', 'Rakefile']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  # spec.add_development_dependency "rake", '~> 2.0.4'

end
