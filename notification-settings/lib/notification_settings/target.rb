require 'active_support'

module NotificationSettings
    module Target

        extend ActiveSupport::Concern

        included do
            has_one :notification_setting, as: :object, class_name: 'NotificationSettings::Setting', dependent: :destroy
            after_create_commit :create_notification_setting

            include NotificationSettings::Target::InstanceMethods
        end

        module InstanceMethods

            private

            def create_notification_setting
                self.notification_setting.create!
            end

        end

    end
end
