# frozen_string_literal: true

version = File.read(File.expand_path('../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.name                  = 'notification-handler'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'Create and modify your notifications through a '\
                              'simple API'
  gem.description           = 'Create and modify your notifications through a '\
                              'simple API.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'me@jonhue.me'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails'\
                              '/tree/master/notification-handler'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*',
                                  'app/**/*']
  gem.require_paths         = ['lib']

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'activerecord', '~> 5.2'
  gem.add_dependency 'activesupport', '~> 5.2'
  gem.add_dependency 'railties', '~> 5.2'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'rubocop-rspec'
end
