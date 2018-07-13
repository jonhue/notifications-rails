# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module Subscriber
    extend ActiveSupport::Concern

    included do
      has_many :notification_subscriptions,
               as: :subscriber,
               class_name: 'NotificationSettings::Subscription',
               dependent: :destroy
      has_many :notification_subscribables,
               through: :notification_subscriptions, source: :subscribable

      include NotificationSettings::Subscriber::InstanceMethods
    end

    module InstanceMethods
      def subscribe(subscribable, options = {})
        options[:subscribable] = subscribable
        notification_subscriptions.create(options)
      end

      def unsubscribe(subscribable)
        subscription = notification_subscriptions.find_by(
          subscribable_id: subscribable.id,
          subscribable_type: subscribable.class.name
        )
        subscription.destroy
      end
    end
  end
end
