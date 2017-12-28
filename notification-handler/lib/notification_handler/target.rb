module NotificationHandler
    module Target

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_target
                has_many :notifications, as: :target, dependent: :destroy
                include NotificationHandler::Target::InstanceMethods

                include NotificationSettings::Target if defined?(NotificationSettings)
                include NotificationSettings::Subscriber if defined?(NotificationSettings)
            end
        end

        module InstanceMethods

            def notify options = {}
                self.notifications.create options
            end

        end

    end
end
