module NotificationSettings
    module SubscriptionLibrary
        
        after_create_commit :create_notification_setting
        
        private
        
        def create_notification_setting
            self.notification_setting.create!
        end

    end
end
