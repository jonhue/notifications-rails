# frozen_string_literal: true

version = File.read(File.expand_path('../../VERSION', __dir__)).strip

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |gem|
  gem.name                  = 'notification-pusher-actionmailer'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'A pusher to send your notifications via email '\
                              'utilizing ActionMailer'
  gem.description           = 'A pusher to send your notifications via email '\
                              'utilizing ActionMailer.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'me@jonhue.me'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails'\
                              '/tree/master/notification-pusher'\
                              '/notification-pusher-actionmailer'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*',
                                  'app/**/*']
  gem.require_paths         = ['lib']

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'actionmailer', '>= 5.0'
  gem.add_dependency 'notification-pusher', version
  gem.add_dependency 'railties', '>= 5.0'

  gem.add_development_dependency 'factory_bot'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rails'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'rubocop-rspec'
  gem.add_development_dependency 'sqlite3'
end
# rubocop:enable Metrics/BlockLength
