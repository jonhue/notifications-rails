module NotificationSettings
    module Subscribable

        has_many :notification_subscriptions, as: :subscribable, class_name: 'NotificationSettings::Subscription', dependent: :destroy
        has_many :notification_subscribers, through: :notification_subscriptions, source: :subscriber
        
        def notify_subscribers options = {}
            self.notification_subscribers.each do |subscriber|
                subscriber.notify object: self, options
            end
        end

    end
end
