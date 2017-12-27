module NotificationSettings
    module Subscribable

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_subscribable
                has_many :notification_subscriptions, as: :subscribable, class_name: 'NotificationSettings::Subscription', dependent: :destroy
                has_many :notification_subscribers, through: :notification_subscriptions, source: :subscriber
                include NotificationSettings::Subscribable::InstanceMethods
            end
        end

        module InstanceMethods
        
            def notify_subscribers options = {}
                self.notification_subscribers.each do |subscriber|
                    subscriber.notify object: self, options
                end
            end

        end

    end
end
