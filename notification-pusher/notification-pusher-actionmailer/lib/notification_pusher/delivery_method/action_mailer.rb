# frozen_string_literal: true

require 'notification-renderer'

module NotificationPusher
  module DeliveryMethod
    class ActionMailer < NotificationPusher::DeliveryMethod::Base
      require_relative 'action_mailer/engine'

      def call
        ::NotificationPusher::ActionMailer::NotificationMailer.push(
          notification, options
        ).deliver
      end
    end
  end
end
