module NotificationsRails
    module Handler
        module NotificationObject

            def self.included base
                base.extend ClassMethods
            end

            module ClassMethods
                def notification_object
                    has_many :notifications, as: :object, dependent: :destroy
                    include NotificationsRails::Handler::NotificationObject::InstanceMethods
                    include NotificationsRails::Handler::NotificationLib
                end
            end

            module InstanceMethods

                # ...

            end

        end
    end
end
