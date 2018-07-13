# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/migration'

module NotificationPusher
  class InstallGenerator < Rails::Generators::Base
    source_root(File.join(File.dirname(__FILE__), '../templates/install'))
    desc 'Install NotificationPusher'

    def create_initializer
      template 'initializer.rb', 'config/initializers/notification-pusher.rb'
    end
  end
end
