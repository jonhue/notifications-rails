# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module SubscriptionLibrary
    extend ActiveSupport::Concern

    included do
      after_create_commit :create_notification_setting

      include NotificationSettings::SubscriptionLibrary::InstanceMethods
    end

    module InstanceMethods
      private

      def create_notification_setting
        notification_setting.create!
      end
    end
  end
end
