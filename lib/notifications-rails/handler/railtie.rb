require 'rails'

module NotificationsRails
    module Handler
            class Railtie < Rails::Railtie

            initializer 'notifications-rails.handler.active_record' do
                ActiveSupport.on_load :active_record do
                    include NotificationsRails::Handler::NotificationTarget
                    include NotificationsRails::Handler::NotificationObject
                end
            end

        end
    end
end
