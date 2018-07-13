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
        if target.notification_setting.present?
          unless status_allows_create? &&
                 settings_allow_create? &&
                 category_allows_create?
            return false
          end
        end
        true
      end

      def status_allows_create?
        !do_not_notify_statuses.include?(target.notification_setting.status)
      end

      def settings_allow_create?
        target.notification_setting.settings.dig(:enabled)
      end

      def category_allows_create?
        target.notification_setting.category_settings.dig(
          category.to_sym,
          :enabled
        )
      end

      def initialize_pusher
        return unless can_push?
        super
      end

      def validate_push
        if target.notification_setting.present?
          return false unless status_allows_push?

          if push.is_a?(Array)
            push.each do |pusher|
              return false unless settings_allow_push?(pusher) && category_allows_push?(pusher)
            end
          else
            return false unless settings_allow_push?(push) && category_allows_push?(push)
          end
        end
        true
      end

      def status_allows_push?
        !do_not_push_statuses.include?(target.notification_setting.status)
      end

      def settings_allow_push?(pusher)
        target.notification_setting.settings.dig(pusher.to_sym) && (target.notification_setting.settings.dig(:index) || target.notification_setting.settings.dig(pusher.to_sym).present?)
      end

      def category_allows_push?(pusher)
        target.notification_setting.category_settings.dig(category.to_sym, pusher.to_sym) && (target.notification_setting.category_settings.dig(category.to_sym, :index) || target.notification_setting.category_settings.dig(category.to_sym, pusher.to_sym).present?)
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
