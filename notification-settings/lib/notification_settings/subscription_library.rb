module NotificationSettings
    module SubscriptionLibrary

        extend ActiveSupport::Concern

        included do
            after_create_commit :create_notification_setting

            include NotificationSettings::SubscriptionLibrary::InstanceMethods
        end

        module InstanceMethods

            private

            def create_notification_setting
                self.notification_setting.create!
            end

        end

    end
end
