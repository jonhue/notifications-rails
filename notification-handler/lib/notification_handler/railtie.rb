require 'rails/railtie'
require 'active_record'

module NotificationHandler
    class Railtie < Rails::Railtie

        initializer 'notification-handler.active_record' do
            ActiveSupport.on_load :active_record do
                include NotificationHandler::Target
                include NotificationHandler::Object
            end
        end

    end
end
