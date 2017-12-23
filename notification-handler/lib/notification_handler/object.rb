module NotificationHandler
    module Object

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_object
                has_many :belonging_notifications, as: :object, dependent: :destroy
                include NotificationHandler::Object::InstanceMethods
            end
        end

        module InstanceMethods

            # ...

        end

    end
end
