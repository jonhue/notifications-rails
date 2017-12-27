module NotificationSettings
    module SubscriptionLibrary
        
        has_many :notifications, class_name: '::Notification'

    end
end
