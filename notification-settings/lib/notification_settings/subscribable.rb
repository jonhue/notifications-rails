module NotificationSettings
    module Subscribable

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def notification_subscribable
                has_many :notification_subscriptions, as: :subscribable, class_name: 'NotificationSettings::Subscription', dependent: :destroy
                include NotificationSettings::Subscribable::InstanceMethods
            end
        end

        module InstanceMethods
        
            def subscribe options = {}
                NotificationSettings::Subscription.create subscribable: self, options
            end

        end

    end
end
