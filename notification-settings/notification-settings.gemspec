# -*- encoding: utf-8 -*-
version = File.read(File.expand_path('../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
    gem.name                  = 'notification-settings'
    gem.version               = version
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'Integrates with your authentication solution to craft a personalized user notification platform'
    gem.description           = 'Integrates with your authentication solution to craft a personalized user notification platform.'
    gem.authors               = 'Jonas Hübotter'
    gem.email                 = 'me@jonhue.me'
    gem.homepage              = 'https://github.com/jonhue/notifications-rails/tree/master/notification-settings'
    gem.license               = 'MIT'

    gem.files                 = Dir['README.md', 'CHANGELOG.md', 'LICENSE', 'lib/**/*', 'app/**/*']
    gem.require_paths         = ['lib']

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'railties', '>= 5.0'
    gem.add_dependency 'activerecord', '>= 5.0'
    gem.add_dependency 'activesupport', '>= 5.0'
    gem.add_dependency 'notification-handler', version

    gem.add_development_dependency 'rspec', '~> 3.7'
    gem.add_development_dependency 'rubocop', '~> 0.52'
end
