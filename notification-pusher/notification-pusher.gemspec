# frozen_string_literal: true

version = File.read(File.expand_path('../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.name                  = 'notification-pusher'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'Deliver your notifications to various services'
  gem.description           = 'Deliver your notifications to various services.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'jonas.huebotter@gmail.com'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails' \
                              '/tree/master/notification-pusher'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*']
  gem.require_paths         = ['lib']
  gem.metadata              = {
    'github_repo' => 'ssh://github.com/jonhue/notifications-rails'
  }

  gem.required_ruby_version = '>= 2.7'

  gem.add_dependency 'activesupport', '>= 5.0'
  gem.add_dependency 'notification-handler', version
end
