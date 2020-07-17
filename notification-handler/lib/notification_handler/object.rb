# frozen_string_literal: true

require 'active_support'

module NotificationHandler
  module Object
    extend ActiveSupport::Concern

    included do
      def self.notification_object
        has_many :belonging_notifications,
                 as: :object, class_name: 'Notification', dependent: :destroy

        include NotificationSettings::Subscribable if defined?(NotificationSettings)
      end
    end
  end
end
