module NotificationHandler
    module Target

        def self.included base
            base.extend ClassMethods
            base.extend NotificationSettings::Object if defined?(NotificationSettings)
            base.extend NotificationSettings::Subscriber if defined?(NotificationSettings)
        end

        module ClassMethods
            def notification_target
                has_many :notifications, as: :target, dependent: :destroy
                include NotificationHandler::Target::InstanceMethods
            end
        end

        module InstanceMethods

            def notify options = {}
                Notification.create target: self, options
            end

        end

    end
end
