module NotificationSettings
    module Object

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_settings
                has_one :notification_setting, as: :object, class_name: 'NotificationSettings::Setting', dependent: :destroy
                include NotificationSettings::Object::InstanceMethods

                after_create_commit :create_notification_setting
            end
        end

        module InstanceMethods

            private

            def create_notification_setting
                self.notification_setting.create!
            end

        end

    end
end
