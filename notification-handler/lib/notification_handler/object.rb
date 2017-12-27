module NotificationHandler
    module Object

        def self.included base
            base.extend ClassMethods
            base.extend NotificationSettings::Subscribable if defined?(NotificationSettings)
        end

        module ClassMethods
            def notification_object
                has_many :belonging_notifications, as: :object, class_name: 'Notification', dependent: :destroy
                include NotificationHandler::Object::InstanceMethods
            end
        end

        module InstanceMethods

            # ...

        end

    end
end
