# frozen_string_literal: true

require 'active_support'

module NotificationHandler
  module Target
    extend ActiveSupport::Concern

    included do
      def self.notification_target
        has_many :notifications, as: :target, dependent: :destroy
        include NotificationHandler::Target::InstanceMethods

        include NotificationSettings::Target if defined?(NotificationSettings)
        # rubocop:disable Style/GuardClause
        if defined?(NotificationSettings)
          include NotificationSettings::Subscriber
        end
        # rubocop:enable Style/GuardClause
      end
    end

    module InstanceMethods
      def notify(options = {})
        notifications.create(options)
      end
    end
  end
end
