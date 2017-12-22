module NotificationsRails
    module NotificationTarget

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_target
                has_many :notifications, as: :target, dependent: :destroy
                include NotificationsRails::NotificationTarget::InstanceMethods
                include NotificationsRails::NotificationLib
            end
        end

        module InstanceMethods

            # ...

        end

    end
end
