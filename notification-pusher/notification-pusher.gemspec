# -*- encoding: utf-8 -*-
version = File.read(File.expand_path('../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
    gem.name                  = 'notification-pusher'
    gem.version               = version
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'Push your notifications to various services. Including Email, ActionCable, OneSignal (cross-platform notifications)'
    gem.description           = 'Push your notifications to various services. Including Email, ActionCable, OneSignal (cross-platform notifications).'
    gem.authors               = 'Jonas Hübotter'
    gem.email                 = 'me@jonhue.me'
    gem.homepage              = 'https://github.com/jonhue/notifications-rails/tree/master/notification-pusher'
    gem.license               = 'MIT'

    gem.files                 = Dir['README.md', 'CHANGELOG.md', 'LICENSE', 'lib/**/*']
    gem.require_paths         = ['lib']

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'activesupport', '>= 5.0'
    gem.add_dependency 'notification-handler', version

    gem.add_development_dependency 'rspec', '~> 3.7'
    gem.add_development_dependency 'rubocop', '~> 0.52'
end
