require 'rails/generators'
require 'rails/generators/migration'

class TypeGenerator < Rails::Generators::Base

    include Rails::Generators::Migration

    source_root File.join File.dirname(__FILE__), 'templates/type'
    desc 'Create a new notification type'
    class_option :type, desc: 'Specify the notification type', type: :string, default: NotificationRenderer.configuration.default_type, aliases: '-t'
    class_option :renderers, desc: 'Specify the renderer templates', type: :string, default: 'index', aliases: '-r'

    def create_templates
        options[:renderers].split(' ')&.each do |template|
            template '_template.html.erb', "app/views/notifications/#{options[:type]}/_#{template}.html.erb"
        end
    end

end
