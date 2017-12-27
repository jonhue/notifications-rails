module NotificationHandler
    module Target

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_target
                has_many :notifications, as: :target, dependent: :destroy
                include NotificationHandler::Target::InstanceMethods
                
                extend NotificationSettings::Target if defined?(NotificationSettings)
                extend NotificationSettings::Subscriber if defined?(NotificationSettings)
            end
        end

        module InstanceMethods

            def notify options = {}
                Notification.create target: self, options
            end

        end

    end
end
