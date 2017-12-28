require 'active_support'

module NotificationSettings
    module Subscribable

        extend ActiveSupport::Concern

        included do
            has_many :notification_subscriptions, as: :subscribable, class_name: 'NotificationSettings::Subscription', dependent: :destroy
            has_many :notification_subscribers, through: :notification_subscriptions, source: :subscriber

            include NotificationSettings::Subscribable::InstanceMethods
        end

        module InstanceMethods

            def notify_subscribers options = {}
                options[:object] = self
                self.notification_subscribers.each do |subscriber|
                    subscriber.notify options
                end
            end

        end

    end
end
