# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/migration'

module NotificationSettings
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root(File.join(File.dirname(__FILE__), '../templates/install'))
    desc 'Install NotificationSettings'

    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime('%Y%m%d%H%M%S')
      else
        format('%.3d', current_migration_number(dirname) + 1)
      end
    end

    def create_initializer
      template 'initializer.rb', 'config/initializers/notification-settings.rb'
    end

    def create_notifications_migration_file
      migration_template(
        'notifications_migration.rb.erb',
        'db/migrate/notification_settings_migration.rb',
        migration_version: migration_version
      )
    end

    private

    def migration_version
      return unless Rails.version >= '5.0.0'
      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    end
  end
end
