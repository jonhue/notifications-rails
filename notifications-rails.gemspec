# frozen_string_literal: true

version = File.read(File.expand_path('VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.name                  = 'notifications-rails'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'The most powerful (cross-platform) '\
                              'notifications handler & pusher API for Rails'
  gem.description           = 'The most powerful notification solution for '\
                              'Rails. Notifications Rails simplifies the '\
                              'handling, rendering, user-integration and '\
                              'cross-platform pushing of notifications '\
                              'through its simple API.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'me@jonhue.me'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE',
                                  'lib/notifications-rails.rb']

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'notification-handler', version
  gem.add_dependency 'notification-pusher', version
  gem.add_dependency 'notification-renderer', version
  gem.add_dependency 'notification-settings', version

  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'combustion'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'pry-rescue'
  gem.add_development_dependency 'pry-stack_explorer'
  gem.add_development_dependency 'rails'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'rubocop-rspec'
  gem.add_development_dependency 'sqlite3'
end
