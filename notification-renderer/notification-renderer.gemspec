# frozen_string_literal: true

version = File.read(File.expand_path('..', 'VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.name                  = 'notification-renderer'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'Render your notifications on multiple '\
                              'platforms by specifying notification types'
  gem.description           = 'Render your notifications on multiple '\
                              'platforms by specifying notification types.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'me@jonhue.me'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails'\
                              '/tree/master/notification-renderer'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*',
                                  'app/**/*']
  gem.require_paths         = ['lib']

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'railties', '~> 5.2'
  gem.add_dependency 'actionview', '~> 5.2'
  gem.add_dependency 'activesupport', '~> 5.2'
  gem.add_dependency 'notification-handler', version

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'rubocop-rspec'
end
