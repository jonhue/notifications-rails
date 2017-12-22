require 'rails'

module NotificationsRails
    class Railtie < Rails::Railtie

        initializer 'notifications-rails.active_record' do
            ActiveSupport.on_load :active_record do
                include NotificationsRails::NotificationTarget
                include NotificationsRails::NotificationObject
            end
        end

    end
end
