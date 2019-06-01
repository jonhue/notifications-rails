# frozen_string_literal: true

module NotificationPusher
  module DeliveryMethod
    class ActionMailer < NotificationPusher::DeliveryMethod::Base
      require_relative 'action_mailer/engine'

      DEFAULT_MAILER_ACTION = :push
      DEFAULT_DELIVER_METHOD = :deliver

      def call
        mailer_class.send(mailer_action, notification, options)
                    .send(deliver_method)
      end

      private

      def mailer_class
        return options[:mailer] if options.key?(:mailer)
        if defined?(NotificationRenderer)
          return ::NotificationPusher::ActionMailer::NotificationMailer
        end

        raise(ArgumentError,
              'You have to pass the :mailer option explicitly or require ' \
              "'notification-renderer'")
      end

      def mailer_action
        options[:action] || DEFAULT_MAILER_ACTION
      end

      def deliver_method
        options[:deliver_method] || DEFAULT_DELIVER_METHOD
      end
    end
  end
end
