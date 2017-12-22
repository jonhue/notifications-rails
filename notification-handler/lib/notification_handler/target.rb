module NotificationHandler
    module Target

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_target
                has_many :notifications, as: :target, dependent: :destroy
                include NotificationHandler::Target::InstanceMethods
                include NotificationHandler::Library
            end
        end

        module InstanceMethods

            # ...

        end

    end
end
