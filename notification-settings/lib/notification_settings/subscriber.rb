require 'active_support'

module NotificationSettings
    module Subscriber

        extend ActiveSupport::Concern

        included do
            has_many :notification_subscriptions, as: :subscriber, class_name: 'NotificationSettings::Subscription', dependent: :destroy
            has_many :notification_subscribables, through: :notification_subscriptions, source: :subscribable

            include NotificationSettings::Subscriber::InstanceMethods
        end

        module InstanceMethods

            def subscribe subscribable, options = {}
                options[:subscribable] = subscribable
                self.notification_subscriptions.create options
            end

            def unsubscribe subscribable
                subscription = self.notification_subscriptions.find_by subscribable_id: subscribable.id, subscribable_type: subscribable.class.to_s
                subscription.destroy
            end

        end

    end
end
