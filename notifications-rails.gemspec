# frozen_string_literal: true

version = File.read(File.expand_path('VERSION', __dir__)).strip

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |gem|
  gem.name                  = 'notifications-rails'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'The most powerful library for the handling and '\
                              '(cross-platform) delivery of notifications '\
                              'with Rails'
  gem.description           = 'notifications-rails is the most powerful '\
                              'notification library for Rails. It offers not '\
                              'only simple APIs to create and render '\
                              'notifications but also supports '\
                              'user-integration and cross-platform delivery '\
                              'of notifications.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'jonas.huebotter@gmail.com'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE',
                                  'lib/notifications-rails.rb']

  gem.required_ruby_version = '>= 2.7'

  gem.add_dependency 'notification-handler', version
  gem.add_dependency 'notification-pusher', version
  gem.add_dependency 'notification-renderer', version
  gem.add_dependency 'notification-settings', version

  gem.add_development_dependency 'factory_bot'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rails'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'rubocop-rails'
  gem.add_development_dependency 'rubocop-rspec'
  gem.add_development_dependency 'sqlite3'
end
# rubocop:enable Metrics/BlockLength
