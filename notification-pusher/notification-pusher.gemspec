# frozen_string_literal: true

version = File.read(File.expand_path('../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.name                  = 'notification-pusher'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'Push your notifications to various services'
  gem.description           = 'Push your notifications to various services. '\
                              'Including Email, ActionCable, OneSignal '\
                              '(cross-platform notifications).'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'me@jonhue.me'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails'\
                              '/tree/master/notification-pusher'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*']
  gem.require_paths         = ['lib']

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'activesupport', '>= 5.0'
  gem.add_dependency 'notification-handler', version

  gem.add_development_dependency 'factory_bot'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rails'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'rubocop-rspec'
  gem.add_development_dependency 'sqlite3'
end
