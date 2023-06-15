# frozen_string_literal: true

version = File.read(File.expand_path('../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.name                  = 'notification-settings'
  gem.version               = version
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'Integrates with your authentication solution ' \
                              'to craft a personalized user notification ' \
                              'platform'
  gem.description           = 'Integrates with your authentication solution ' \
                              'to craft a personalized user notification ' \
                              'platform.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'jonas.huebotter@gmail.com'
  gem.homepage              = 'https://github.com/jonhue/notifications-rails' \
                              '/tree/master/notification-settings'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*',
                                  'app/**/*']
  gem.require_paths         = ['lib']
  gem.metadata              = {
    'github_repo' => 'ssh://github.com/jonhue/notifications-rails'
  }

  gem.required_ruby_version = '>= 2.7'

  gem.add_dependency 'activemodel', '>= 5.0'
  gem.add_dependency 'activerecord', '>= 5.0'
  gem.add_dependency 'activesupport', '>= 5.0'
  gem.add_dependency 'hashie', '>= 3.6', '< 6.0'
  gem.add_dependency 'notification-handler', version
  gem.add_dependency 'railties', '>= 5.0'
end
