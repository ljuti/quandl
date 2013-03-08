# -*- encoding: utf-8 -*-

require File.expand_path('../lib/quandl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "quandl"
  gem.version       = Quandl::VERSION
  gem.summary       = %q{TODO: Summary}
  gem.description   = %q{TODO: Description}
  gem.license       = "MIT"
  gem.authors       = ["Lauri Jutila"]
  gem.email         = "ruby@laurijutila.com"
  gem.homepage      = "https://github.com/ljuti/quandl"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency "httparty"
  gem.add_dependency "activesupport"

  gem.add_development_dependency "webmock"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "turn"
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
end
