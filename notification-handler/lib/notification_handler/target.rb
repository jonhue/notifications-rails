# frozen_string_literal: true

module NotificationHandler
  module Target
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def notification_target
        has_many :notifications, as: :target, dependent: :destroy
        include NotificationHandler::Target::InstanceMethods

        include NotificationSettings::Target if defined?(NotificationSettings)
        return unless defined?(NotificationSettings)
        include NotificationSettings::Subscriber
      end
    end

    module InstanceMethods
      def notify(options = {})
        notifications.create(options)
      end
    end
  end
end
