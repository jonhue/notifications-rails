# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationPusher
  module NotificationLib
    extend ActiveSupport::Concern

    included do
      attr_accessor :delivery_method
      attr_accessor :delivery_options

      after_create_commit :deliver_after_create_commit

      include NotificationPusher::NotificationLib::InstanceMethods
    end

    module InstanceMethods
      def deliver(delivery_methods, delivery_options = {})
        return false unless delivery_methods
        return deliver!(delivery_methods, delivery_options) unless delivery_methods.is_a?(Array)

        delivery_methods.each do |delivery_method|
          deliver(delivery_method,
                  delivery_options[delivery_method.to_sym] || {})
        end
      end

      def deliver!(name, options = {})
        delivery_method = NotificationPusher::DeliveryMethodConfiguration
                          .find_by_name!(name)
        delivery_method.call(self, options)
      end

      private

      # If delivery_method attribute was specified
      # when object was built/created, deliver using that delivery method
      def deliver_after_create_commit
        return if delivery_method.nil?

        deliver(delivery_method, delivery_options || {})
      end
    end
  end
end
