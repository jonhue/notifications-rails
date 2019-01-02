# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module Target
    extend ActiveSupport::Concern

    included do
      has_one :notification_setting,
              as: :object,
              class_name: 'NotificationSettings::Setting',
              dependent: :destroy
      before_create :build_notification_setting

      include NotificationSettings::Target::InstanceMethods
    end

    module InstanceMethods
      def notification_setting
        super || build_notification_setting
      end
    end
  end
end
