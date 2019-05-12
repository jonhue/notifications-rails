# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module Subscribable
    extend ActiveSupport::Concern

    included do
      has_many :notification_subscribers,
               as: :subscribable,
               class_name: 'NotificationSettings::Subscription',
               dependent: :destroy

      include NotificationSettings::Subscribable::InstanceMethods
    end

    module InstanceMethods
      def notify_subscribers(options = {})
        options[:object] = self
        subscriptions = notify_dependents(options.delete(:dependents))
        notification_subscribers&.each do |subscription|
          subscriptions << subscription
        end
        subscriptions.to_a.uniq&.each do |subscription|
          subscription.subscriber.notify(options)
        end
      end

      def notify_dependents(dependents)
        subscriptions = []
        dependents ||= notification_dependents
        dependents&.each do |dependent|
          dependent.notification_subscribers&.each do |subscription|
            subscriptions << subscription
          end
        end
        subscriptions
      end

      private

      def notification_dependents
        []
      end
    end
  end
end
