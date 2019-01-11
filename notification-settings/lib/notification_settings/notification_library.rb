# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationSettings
  module NotificationLibrary
    extend ActiveSupport::Concern

    included do
      before_create :validate_create

      belongs_to :subscription,
                 class_name: 'NotificationSettings::Subscription',
                 optional: true

      include NotificationSettings::NotificationLibrary::InstanceMethods
    end

    module InstanceMethods
      def category
        self[:category] || NotificationSettings.configuration.default_category
      end

      private

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
        value = target.notification_setting.category_settings.dig(
          category.to_sym,
          :enabled
        )
        value.nil? ? true : value
      end

      def initialize_pusher
        return unless can_push?
        super
      end

      def can_push?
        return true unless target.notification_setting.present?
        status_allows_push? &&
          can_use_pushers?(Array(pusher))
      end

      def can_use_pushers?(pushers)
        pushers.all? do |pusher|
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

      def settings_allow_push?(pusher)
        return global_settings_allow_push? unless local_pusher_settings?(pusher)
        local_settings_allow_push?(pusher)
      end

      def local_pusher_settings?(pusher)
        local_settings_allow_push?(pusher).present?
      end

      def local_settings_allow_push?(pusher)
        target.notification_setting.settings.dig(pusher.to_sym)
      end

      def global_settings_allow_push?
        target.notification_setting.settings.fetch(:index, true)
      end

      def category_settings_allow_push?(pusher)
        if local_pusher_category_settings?(pusher)
          local_category_settings_allow_push?(pusher)
        else
          global_category_settings_allow_push?
        end
      end

      def local_pusher_category_settings?(pusher)
        local_category_settings_allow_push?(pusher).present?
      end

      def local_category_settings_allow_push?(pusher)
        value = target.notification_setting.category_settings.dig(
          category.to_sym,
          pusher.to_sym
        )
        value.nil? ? true : value
      end

      def global_category_settings_allow_push?
        value = target.notification_setting.category_settings.dig(
          category.to_sym,
          :index
        )
        value.nil? ? true : value
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
