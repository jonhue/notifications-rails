require 'rails/generators'
require 'rails/generators/migration'

class InstallGenerator < Rails::Generators::Base

    include Rails::Generators::Migration

    source_root File.join File.dirname(__FILE__), 'templates/install'
    desc 'Install NotificationPusher for ActionMailer'

    def create_initializer
        template 'initializer.rb', 'config/initializers/notification-pusher-actionmailer.rb'
    end

end
