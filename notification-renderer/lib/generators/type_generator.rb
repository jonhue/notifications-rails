require 'rails/generators'
require 'rails/generators/migration'

class TypeGenerator < Rails::Generators::Base

    include Rails::Generators::Migration

    source_root File.join File.dirname(__FILE__), 'templates/type'
    desc 'Create a new notification type'
    class_option :type, desc: 'Specify the notification type', type: :string, default: NotificationRenderer.configuration.default_type, aliases: '-t'

    def create_templates
        template '_default.html.erb', "app/views/notifications/#{options[:type]}/_default.html.erb"
        template '_action_cable.html.erb', "app/views/notifications/#{options[:type]}/_action_cable.html.erb" if defined?(NotificationPusher::ActionCable)
        template '_email.html.erb', "app/views/notifications/#{options[:type]}/_email.html.erb" if defined?(NotificationPusher::Email)
        template '_one_signal.html.erb', "app/views/notifications/#{options[:type]}/_one_signal.html.erb" if defined?(NotificationPusher::OneSignal)
    end

end
