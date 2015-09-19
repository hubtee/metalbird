$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'metalbird/version'

Gem::Specification.new do |spec|
  # Project
  spec.name        = 'metalbird'
  spec.version     = Metalbird::VERSION
  spec.licenses    = ['MIT']
  spec.platform    = Gem::Platform::RUBY
  spec.homepage    = 'http://metalbird.hubtee.com'
  spec.summary     = 'Library for publishing your contents to various platforms'
  spec.description = 'Library for publishing your contents to various platforms'

  # Requirement
  spec.required_ruby_version = '>= 2.0.0'

  # Author
  spec.authors     = ['Daekwon Kim']
  spec.email       = ['propellerheaven@gmail.com']

  # Files
  all_files = `git ls-files -z`.split("\x0")
  spec.files = all_files.grep(%r{^(bin|lib)/})
  spec.executables = all_files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # spec.has_rdoc = true
  # spec.extra_rdoc_files = ['']
  # spec.rdoc_options = ['--line-numbers', "--main", "README.rdoc"]

  # Dependency
  spec.add_dependency('twitter', '~> 5')
  spec.add_dependency('oauth', '~> 0.4')
  spec.add_dependency('tumblr_client', '~> 0.8')

  # Development Dependency
  spec.add_development_dependency('guard')
  spec.add_development_dependency('guard-rspec')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('twitter-text')
  spec.add_development_dependency('coveralls')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('dotenv')
end
