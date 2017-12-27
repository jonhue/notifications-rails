module NotificationSettings
    module Subscriber

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_subscriber
                has_many :notification_subscriptions, as: :subscriber, class_name: 'NotificationSettings::Subscription', dependent: :destroy
                has_many :notification_subscribables, through: :notification_subscriptions, source: :subscribable
                include NotificationSettings::Subscriber::InstanceMethods
            end
        end

        module InstanceMethods
        
            def subscribe options = {}
                NotificationSettings::Subscription.create subscriber: self, options
            end
            
            def unsubscribe subscribable
                subscription = self.notification_subscriptions.find_by subscribable_id: subscribable.id, subscribable_type: subscribable.class.to_s
                subscription.destroy
            end

        end

    end
end
