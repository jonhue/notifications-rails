# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module Subscriber
    extend ActiveSupport::Concern

    included do
      has_many :notification_subscribables,
               as: :subscriber,
               class_name: 'NotificationSettings::Subscription',
               dependent: :destroy

      include NotificationSettings::Subscriber::InstanceMethods
    end

    module InstanceMethods
      def subscribe(subscribable, options = {})
        notification_subscribables.create(
          options.merge(subscribable: subscribable)
        )
      end

      def unsubscribe(subscribable)
        subscription = notification_subscribables.find_by(
          subscribable_id: subscribable.id,
          subscribable_type: subscribable.class.name
        )
        subscription&.destroy
      end
    end
  end
end
