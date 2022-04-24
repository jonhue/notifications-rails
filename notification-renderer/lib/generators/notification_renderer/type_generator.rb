# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/migration'

module NotificationRenderer
  class TypeGenerator < Rails::Generators::Base
    source_root(File.join(File.dirname(__FILE__), '../templates/type'))
    desc 'Create a new notification type'
    class_option :type,
                 desc: 'Specify the notification type',
                 type: :string,
                 default: NotificationRenderer.configuration.default_type,
                 aliases: '-t'
    class_option :renderers,
                 desc: 'Specify the renderer templates',
                 type: :string,
                 default: NotificationRenderer.configuration.default_renderer,
                 aliases: '-r'

    def create_templates
      options[:renderers].split&.each do |template|
        template(
          '_template.html',
          "app/views/notifications/#{options[:type]}/_#{template}.html.erb"
        )
      end
    end
  end
end
