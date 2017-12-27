class NotificationSettings::Subscription < ActiveRecord::Base

    self.table_name = 'notification_settings_subscriptions'

    extend NotificationSettings::SubscriptionLibrary

    belongs_to :subscriber, polymorphic: true
    belongs_to :subscribable, polymorphic: true

end
