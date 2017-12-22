# -*- encoding: utf-8 -*-
version = File.read(File.expand_path('VERSION', __dir__)).strip

Gem::Specification.new do |gem|
    gem.name                  = 'notifications-rails'
    gem.version               = version
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'The most powerful (cross-platform) notifications handler & pusher API for Rails'
    gem.description           = '...'
    gem.authors               = 'Jonas Hübotter'
    gem.email                 = 'jonas.huebotter@gmail.com'
    gem.homepage              = 'https://github.com/jonhue/notifications-rails'
    gem.license               = 'MIT'

    gem.files                 = Dir['README.md', 'INSTALL.md', 'LICENSE']

    gem.post_install_message  = IO.read('INSTALL.md')

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'rails', '>= 5.0'
    gem.add_dependency 'notification-handler', version
    gem.add_dependency 'notification-pusher', version
    gem.add_dependency 'notification-settings', version

    gem.add_development_dependency 'rake', '~> 12.3'
    gem.add_development_dependency 'rubocop', '~> 0.52'
end
