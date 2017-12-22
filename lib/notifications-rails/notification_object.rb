module NotificationsRails
    module NotificationObject

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_object
                has_many :notifications, as: :object, dependent: :destroy
                include NotificationsRails::NotificationObject::InstanceMethods
                include NotificationsRails::NotificationLib
            end
        end

        module InstanceMethods

            # ...

        end

    end
end
