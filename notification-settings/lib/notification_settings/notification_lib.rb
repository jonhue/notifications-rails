# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationSettings
  module NotificationLib
    extend ActiveSupport::Concern

    included do
      before_create :validate_create
      validates :target, presence: true

      belongs_to :subscription,
                 class_name: 'NotificationSettings::Subscription',
                 optional: true

      include NotificationSettings::NotificationLib::InstanceMethods
    end

    module InstanceMethods
      def category
        self[:category] || NotificationSettings.configuration.default_category
      end

      def category_setting
        target.notification_setting.category_settings.fetch(category.to_sym, {})
      end

      def push(pushers, pusher_options = {})
        return false unless push_allowed?(pushers)

        super
      end

      def creation_allowed?
        return true unless target.notification_setting.present?

        status_allows_creation? &&
          settings_allow_creation? &&
          category_settings_allow_creation?
      end

      # pusher may be an array or a single value
      def push_allowed?(pusher)
        return true unless target.notification_setting.present?

        creation_allowed? &&
          status_allows_push? &&
          pushers_allowed?(Array(pusher))
      end

      private

      def validate_create
        throw(:abort) unless creation_allowed?
      end

      def status_allows_creation?
        !do_not_notify_statuses.include?(target.notification_setting.status)
      end

      def settings_allow_creation?
        target.notification_setting.settings.fetch(:enabled, true)
      end

      def category_settings_allow_creation?
        category_setting.fetch(:enabled, true)
      end

      def pushers_allowed?(pushers)
        pushers.any? do |pusher|
          pusher_allowed?(pusher)
        end
      end

      def pusher_allowed?(pusher)
        settings_allow_push?(pusher) &&
          category_settings_allow_push?(pusher)
      end

      def status_allows_push?
        !do_not_push_statuses.include?(target.notification_setting.status)
      end

      def settings_allow_push?(pusher)
        if local_pusher_setting?(pusher)
          local_settings_allow_push?(pusher)
        else
          global_settings_allow_push?
        end
      end

      def local_pusher_setting?(pusher)
        !local_pusher_setting(pusher).nil?
      end

      def local_settings_allow_push?(pusher)
        local_pusher_setting(pusher, true)
      end

      def local_pusher_setting(pusher, default = nil)
        target.notification_setting.settings.fetch(pusher.to_sym, default)
      end

      def global_settings_allow_push?
        target.notification_setting.settings.fetch(:pusher_enabled, true)
      end

      def category_settings_allow_push?(pusher)
        if local_pusher_category_setting?(pusher)
          local_category_settings_allow_push?(pusher)
        else
          global_category_settings_allow_push?
        end
      end

      def local_pusher_category_setting?(pusher)
        !local_pusher_category_setting(pusher).nil?
      end

      def local_category_settings_allow_push?(pusher)
        local_pusher_category_setting(pusher, true)
      end

      def local_pusher_category_setting(pusher, default = nil)
        category_setting.fetch(pusher.to_sym, default)
      end

      def global_category_settings_allow_push?
        category_setting.fetch(:pusher_enabled, true)
      end

      def do_not_notify_statuses
        NotificationSettings.configuration.do_not_notify_statuses
      end

      def do_not_push_statuses
        NotificationSettings.configuration.do_not_push_statuses
      end
    end
  end
end
