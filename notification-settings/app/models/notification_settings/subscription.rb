class NotificationSettings::Subscription < ActiveRecord::Base

    self.table_name = 'notification_settings_subscriptions'

    extend NotificationSettings::SubscriptionLibrary

    belongs_to :subscriber, polymorphic: true
    belongs_to :subscribable, polymorphic: true
    
    has_many :notifications, class_name: '::Notification'
    has_one :notification_setting, class_name: 'Setting'
        
    after_create_commit :create_notification_setting

end
