# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module Subscribable
    extend ActiveSupport::Concern

    included do
      has_many :notification_subscriptions,
               as: :subscribable,
               class_name: 'NotificationSettings::Subscription',
               dependent: :destroy
      has_many :notification_subscribers,
               through: :notification_subscriptions, source: :subscriber

      include NotificationSettings::Subscribable::InstanceMethods
    end

    module InstanceMethods
      def notify_subscribers(options = {})
        options[:object] = self
        subscribers = notify_dependents(options.delete(:dependents))
        notification_subscribers&.each do |subscriber|
          subscribers << subscriber
        end
        subscribers.to_a.uniq&.each do |subscriber|
          subscriber.notify(options)
        end
      end

      def notify_dependents(dependents)
        subscribers = []
        dependents ||= notification_dependents
        dependents&.each do |dependent|
          dependent.notification_subscribers&.each do |subscriber|
            subscribers << subscriber
          end
        end
        subscribers
      end

      private

      def notification_dependents
        []
      end
    end
  end
end
