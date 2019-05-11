# frozen_string_literal: true

module NotificationPusher
  module DeliveryMethod
    class Base
      attr_reader :notification, :options

      def initialize(notification, options = {})
        @notification = notification
        @options = options
      end

      def call
        raise NotImplementedError, 'Implement a `call` method that delivers the notification.'
      end
    end
  end
end
