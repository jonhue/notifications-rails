module NotificationSettings
    module Subscriber

        has_many :notification_subscriptions, as: :subscriber, class_name: 'NotificationSettings::Subscription', dependent: :destroy
        has_many :notification_subscribables, through: :notification_subscriptions, source: :subscribable

        def subscribe options = {}
            options[:subscriber] = self
            NotificationSettings::Subscription.create options
        end

        def unsubscribe subscribable
            subscription = self.notification_subscriptions.find_by subscribable_id: subscribable.id, subscribable_type: subscribable.class.to_s
            subscription.destroy
        end

    end
end
