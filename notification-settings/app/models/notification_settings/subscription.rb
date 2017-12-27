class NotificationSettings::Subscription < ActiveRecord::Base

    self.table_name = 'notification_settings_subscriptions'

    extend NotificationSettings::SubscriptionLibrary

    belongs_to :target, polymorphic: true
    belongs_to :object, polymorphic: true

end
