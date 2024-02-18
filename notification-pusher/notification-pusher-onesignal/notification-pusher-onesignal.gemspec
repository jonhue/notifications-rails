# frozen_string_literal: true

version = File.read(File.expand_path('../../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.name                  = 'notification-pusher-onesignal'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'A delivery method to send your notifications ' \
                              'to devices on all platforms with OneSignal'
  gem.description           = 'A delivery method to send your notifications ' \
                              'to devices on all platforms with OneSignal.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'jonas.huebotter@gmail.com'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails' \
                              '/tree/master/notification-pusher' \
                              '/notification-pusher-onesignal'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*']
  gem.require_paths         = ['lib']
  gem.metadata              = {
    'github_repo' => 'ssh://github.com/jonhue/notifications-rails'
  }

  gem.required_ruby_version = '>= 3.0'

  gem.add_dependency 'notification-pusher', version
  gem.add_dependency 'one_signal', '~> 1.2'
end
