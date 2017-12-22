module NotificationsRails
    module Handler
        module NotificationTarget

            def self.included base
                base.extend ClassMethods
            end

            module ClassMethods
                def notification_target
                    has_many :notifications, as: :target, dependent: :destroy
                    include NotificationsRails::Handler::NotificationTarget::InstanceMethods
                    include NotificationsRails::Handler::NotificationLib
                end
            end

            module InstanceMethods

                # ...

            end

        end
    end
end
