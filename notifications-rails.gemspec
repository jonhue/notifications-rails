# -*- encoding: utf-8 -*-
require File.expand_path(File.join('..', 'lib', 'notifications-rails', 'version'), __FILE__)

Gem::Specification.new do |gem|
    gem.name                  = 'notifications-rails'
    gem.version               = NotificationsRails::VERSION
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'The most powerful (cross-platform) notifications handler & pusher API for Rails'
    gem.description           = 'The most powerful (cross-platform) notifications handler & pusher API for Rails.'
    gem.authors               = 'Jonas Hübotter'
    gem.email                 = 'jonas.huebotter@gmail.com'
    gem.homepage              = 'https://github.com/jonhue/notifications-rails'
    gem.license               = 'MIT'

    gem.files                 = `git ls-files`.split("\n")
    gem.require_paths         = ['lib']

    gem.post_install_message  = IO.read('INSTALL.md')

    gem.required_ruby_version = '>= 2.3'

    gem.add_development_dependency 'bundler', '~> 1.16'
    gem.add_development_dependency 'rake', '~> 10.0'
    gem.add_development_dependency 'rspec-rails', '~> 3.7'
    gem.add_development_dependency 'rubocop', '~> 0.52'
    gem.add_dependency 'rails', '>= 5.0'
end
