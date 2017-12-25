module NotificationHandler
    module Object

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_object
                has_many :belonging_notifications, as: :object, class_name: 'Notification', dependent: :destroy
                include NotificationHandler::Object::InstanceMethods
            end
        end

        module InstanceMethods

            def notify options = {}
                Notification.create object: self, options
            end

        end

    end
end
