# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module SubscriptionLibrary
    extend ActiveSupport::Concern

    included do
      before_create :build_notification_setting

      include NotificationSettings::SubscriptionLibrary::InstanceMethods
    end

    module InstanceMethods
      def notification_setting
        super || build_notification_setting
      end
    end
  end
end
