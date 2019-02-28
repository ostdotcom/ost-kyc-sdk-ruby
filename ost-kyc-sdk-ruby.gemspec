# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ost-kyc-sdk-ruby/version'

Gem::Specification.new do |spec|

  spec.name          = "ost-kyc-sdk-ruby"
  spec.version       = OstKycSdkRuby::VERSION
  spec.authors       = ['OST']
  spec.email         = []
  spec.summary       = 'OST KYC Ruby SDK'
  spec.description   = 'OST KYC Ruby SDK provides easy integration with https://kyc.ost.com, the API for OST KYC.'
  spec.homepage      = "https://kyc.ost.com"
  spec.license       = "MIT"
  spec.metadata      = {
                        "documentation_uri" => "https://dev.ost.com/docs/kyc/index.html"
                      }

  spec.files         = Dir['{lib}/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "test-unit", "3.3.0"

  spec.add_development_dependency "bundler", "~> 2.0"

end
