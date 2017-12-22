# -*- encoding: utf-8 -*-
version = File.read(File.expand_path('../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
    gem.name                  = 'notification-settings'
    gem.version               = version
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = '...'
    gem.description           = '...'
    gem.authors               = 'Jonas Hübotter'
    gem.email                 = 'jonas.huebotter@gmail.com'
    gem.homepage              = 'https://github.com/jonhue/notifications-rails/tree/master/notification-settings'
    gem.license               = 'MIT'

    gem.files                 = Dir['README.md', 'CHANGELOG.md', 'LICENSE', 'lib/**/*', 'generators/**/*']
    gem.require_paths         = ['lib']

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'rails', '>= 5.0'

    gem.add_development_dependency 'rubocop', '~> 0.52'
end
