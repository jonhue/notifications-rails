# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationSettings
  module NotificationLibrary
    extend ActiveSupport::Concern

    included do
      before_create :validate_create
      validates :target, presence: true

      belongs_to :subscription,
                 class_name: 'NotificationSettings::Subscription',
                 optional: true

      include NotificationSettings::NotificationLibrary::InstanceMethods
    end

    module InstanceMethods
      def category
        self[:category] || NotificationSettings.configuration.default_category
      end

      def category_setting
        target.notification_setting.category_settings.fetch(category.to_sym, {})
      end

      def push(pushers, pusher_options = {})
        return unless can_push?(pushers)
        super
      end

      private

      # Overall ability to create

      def validate_create
        throw(:abort) unless can_create?
      end

      def can_create?
        return true unless target.notification_setting.present?

        status_allows_create? &&
          settings_allow_create? &&
          category_settings_allow_create?
      end

      def status_allows_create?
        !do_not_notify_statuses.include?(target.notification_setting.status)
      end

      def settings_allow_create?
        target.notification_setting.settings.fetch(:enabled, true)
      end

      def category_settings_allow_create?
        category_setting.fetch(:enabled, true)
      end

      # Overall ability to push

      # pusher may be an array or a single value
      def can_push?(pusher)
        return true unless target.notification_setting.present?

        status_allows_push? &&
          can_use_pushers?(Array(pusher))
      end

      def can_use_pushers?(pushers)
        pushers.any? do |pusher|
          can_use_pusher?(pusher)
        end
      end

      def can_use_pusher?(pusher)
        settings_allow_push?(pusher) &&
          category_settings_allow_push?(pusher)
      end

      def status_allows_push?
        !do_not_push_statuses.include?(target.notification_setting.status)
      end

      # settings_allow_push?

      def settings_allow_push?(pusher)
        if local_pusher_setting?(pusher)
          local_settings_allow_push?(pusher)
        else
          global_settings_allow_push?
        end
      end

      # local_settings_allow_push?

      def local_pusher_setting?(pusher)
        !local_pusher_setting(pusher).nil?
      end

      def local_settings_allow_push?(pusher)
        local_pusher_setting(pusher, true)
      end

      def local_pusher_setting(pusher, default = nil)
        target.notification_setting.settings.fetch(pusher.to_sym, default)
      end

      # global_settings_allow_push?

      def global_settings_allow_push?
        target.notification_setting.settings.fetch(:pusher_enabled, true)
      end

      # category_settings_allow_push?

      def category_settings_allow_push?(pusher)
        if local_pusher_category_setting?(pusher)
          local_category_settings_allow_push?(pusher)
        else
          global_category_settings_allow_push?
        end
      end

      # local_category_settings_allow_push?

      def local_pusher_category_setting?(pusher)
        !local_pusher_category_setting(pusher).nil?
      end

      def local_category_settings_allow_push?(pusher)
        local_pusher_category_setting(pusher, true)
      end

      def local_pusher_category_setting(pusher, default = nil)
        category_setting.fetch(pusher.to_sym, default)
      end

      # global_category_settings_allow_push?

      def global_category_settings_allow_push?
        category_setting.fetch(:pusher_enabled, true)
      end

      # Status

      def do_not_notify_statuses
        NotificationSettings.configuration.do_not_notify_statuses
      end

      def do_not_push_statuses
        NotificationSettings.configuration.do_not_push_statuses
      end
    end
  end
end
