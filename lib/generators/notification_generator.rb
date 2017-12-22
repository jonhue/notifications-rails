require 'rails/generators'
require 'rails/generators/migration'

class NotificationGenerator < Rails::Generators::Base

    include Rails::Generators::Migration

    source_root File.join File.dirname(__FILE__), 'templates/notification'
    desc 'Create a new notification type'
    class_option :type, desc: 'Specify the notification type', type: :string, default: NotificationsRails.configuration.default_type, aliases: '-t'

    def create_templates
        template '_index.html.erb', "app/views/notifications/#{options[:type]}/_index.html.erb"
        template '_action_cable.html.erb', "app/views/notifications/#{options[:type]}/_action_cable.html.erb" # if action_cable-pusher gem installed
        template '_email.html.erb', "app/views/notifications/#{options[:type]}/_email.html.erb" # if email-pusher gem installed
        template '_onesignal.html.erb', "app/views/notifications/#{options[:type]}/_onesignal.html.erb" # if onesignal-pusher gem installed
    end

end
