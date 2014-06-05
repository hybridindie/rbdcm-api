# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dcm/version'

Gem::Specification.new do |spec|
  spec.name          = 'rbdcm-api'
  spec.version       = DCM::VERSION
  spec.authors       = ['John Dilts']
  spec.email         = ['john.dilt@software.dell.com']
  spec.description   = %q{Ruby Interface to work with the Dell Cloud Manager API}
  spec.summary       = %q{Dell Cloud Manager API Ruby Library}
  spec.homepage      = 'http://software.dell.com/products/cloud-manager/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1.0'

  spec.add_development_dependency 'rspec', '3.0.0'
  spec.add_development_dependency 'timecop', '~> 0.7.1'
  spec.add_development_dependency 'simplecov', '0.8.2'
  spec.add_development_dependency 'coveralls', '0.7.0'
  spec.add_development_dependency 'pry', '0.9.12.6'
end
