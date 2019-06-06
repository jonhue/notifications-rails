# frozen_string_literal: true

require 'active_support'

module NotificationHandler
  module Object
    extend ActiveSupport::Concern

    included do
      def self.notification_object
        has_many :belonging_notifications,
                 as: :object, class_name: 'Notification', dependent: :destroy

        # rubocop:disable Style/GuardClause
        if defined?(NotificationSettings)
          include NotificationSettings::Subscribable
        end
        # rubocop:enable Style/GuardClause
      end
    end
  end
end
