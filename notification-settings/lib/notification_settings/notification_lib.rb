# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationSettings
  module NotificationLib
    extend ActiveSupport::Concern

    included do
      before_create :validate_create

      validates :category, inclusion: {
        in: NotificationSettings.configuration.categories + [nil]
      }

      belongs_to :subscription,
                 class_name: 'NotificationSettings::Subscription',
                 optional: true

      include NotificationSettings::NotificationLib::InstanceMethods
    end

    # rubocop:disable Metrics/ModuleLength
    module InstanceMethods
      def category
        self[:category] || NotificationSettings.configuration.default_category
      end

      def deliver(delivery_methods, delivery_options = {})
        return false unless delivery_allowed?(delivery_methods)

        super
      end

      def creation_allowed?
        status_allows_creation? &&
          settings_allow_creation? &&
          category_settings_allow_creation?
      end

      # delivery_methods may be an array or a single value
      def delivery_allowed?(delivery_methods)
        creation_allowed? &&
          status_allows_delivery? &&
          delivery_methods_allowed?(Array(delivery_methods))
      end

      private

      def validate_create
        throw(:abort) unless creation_allowed?
      end

      def status_allows_creation?
        !do_not_notify_statuses.include?(target.status)
      end

      def settings_allow_creation?
        target.settings.fetch(:enabled, true) &&
          (subscription.nil? || subscription.settings.fetch(:enabled, true))
      end

      def category_settings_allow_creation?
        category_settings(target, category).fetch(:enabled, true) &&
          (subscription.nil? ||
            category_settings(subscription, category).fetch(:enabled, true))
      end

      def delivery_methods_allowed?(delivery_methods)
        delivery_methods.any? do |delivery_method|
          delivery_method_allowed?(delivery_method)
        end
      end

      def delivery_method_allowed?(delivery_method)
        settings_allow_delivery?(delivery_method) &&
          category_settings_allow_delivery?(delivery_method)
      end

      def status_allows_delivery?
        !do_not_deliver_statuses.include?(target.status)
      end

      def settings_allow_delivery?(delivery_method)
        if local_delivery_method_setting?(delivery_method)
          local_settings_allow_delivery?(delivery_method)
        else
          global_settings_allow_delivery?
        end
      end

      def local_delivery_method_setting?(delivery_method)
        !local_delivery_method_setting(delivery_method).nil?
      end

      def local_settings_allow_delivery?(delivery_method)
        local_delivery_method_setting(delivery_method, true)
      end

      def local_delivery_method_setting(delivery_method, default = nil)
        delivery_method_setting(target, delivery_method, default) &&
          (subscription.nil? ||
            delivery_method_setting(subscription, delivery_method, default))
      end

      def global_settings_allow_delivery?
        delivery_method_setting(target, :enabled, true) &&
          (subscription.nil? ||
            delivery_method_setting(subscription, :enabled, true))
      end

      def category_settings_allow_delivery?(delivery_method)
        if local_delivery_method_category_setting?(delivery_method)
          local_category_settings_allow_delivery?(delivery_method)
        else
          global_category_settings_allow_delivery?
        end
      end

      def local_delivery_method_category_setting?(delivery_method)
        !local_delivery_method_category_setting(delivery_method).nil?
      end

      def local_category_settings_allow_delivery?(delivery_method)
        local_delivery_method_category_setting(delivery_method, true)
      end

      def local_delivery_method_category_setting(delivery_method, default = nil)
        category_delivery_method_setting(target, category, delivery_method,
                                         default) &&
          (subscription.nil? ||
            category_delivery_method_setting(subscription, category,
                                             delivery_method, default))
      end

      def global_category_settings_allow_delivery?
        category_delivery_method_setting(target, category, :enabled, true) &&
          (subscription.nil? ||
            category_delivery_method_setting(subscription, category, :enabled,
                                             true))
      end

      def delivery_method_setting(object, delivery_method, default)
        object.settings.delivery_methods_.fetch(delivery_method.to_s, default)
      end

      def category_settings(object, category)
        object.settings.categories_.send("#{category}_")
      end

      def category_delivery_method_setting(object, category, delivery_method,
                                           default)
        category_settings(object, category).delivery_methods_
                                           .fetch(delivery_method.to_s, default)
      end

      def do_not_notify_statuses
        NotificationSettings.configuration.do_not_notify_statuses
      end

      def do_not_deliver_statuses
        NotificationSettings.configuration.do_not_deliver_statuses
      end
    end
    # rubocop:enable Metrics/ModuleLength
  end
end
