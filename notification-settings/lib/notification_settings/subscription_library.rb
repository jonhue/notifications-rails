module NotificationSettings
    module SubscriptionLibrary
        
        has_many :notifications, class_name: '::Notification'
        has_one :setting
        
        after_create_commit :create_notification_setting
        
        private
        
        def create_notification_setting
            self.notification_setting.create!
        end

    end
end
