module NotificationSettings
    module Object

        has_one :notification_setting, as: :object, class_name: 'NotificationSettings::Setting', dependent: :destroy
        include NotificationSettings::Object::InstanceMethods

        after_create_commit :create_notification_setting

        private

        def create_notification_setting
            self.notification_setting.create!
        end

    end
end
