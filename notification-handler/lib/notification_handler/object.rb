module NotificationHandler
    module Object

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_object
                has_many :notifications, as: :object, dependent: :destroy
                include NotificationHandler::Object::InstanceMethods
                include NotificationHandler::Library
            end
        end

        module InstanceMethods

            # ...

        end

    end
end
