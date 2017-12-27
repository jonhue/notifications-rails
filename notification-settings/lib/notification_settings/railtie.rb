require 'railties'

module NotificationSettings
    class Railtie < Rails::Railtie

        initializer 'notification-settings.active_record' do
            ActiveSupport.on_load :active_record do
                include NotificationSettings::Object
                include NotificationSettings::Subscriber
                include NotificationSettings::Subscribable
            end
        end

    end
end
