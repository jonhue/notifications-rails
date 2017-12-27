module NotificationSettings
    module Subscriber

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_subscriber
                has_many :notification_subscriptions, as: :subscriber, class_name: 'NotificationSettings::Subscription', dependent: :destroy
                include NotificationSettings::Subscriber::InstanceMethods
            end
        end

        module InstanceMethods
        
            def subscribe options = {}
                NotificationSettings::Subscription.create subscriber: self, options
            end

        end

    end
end
