# frozen_string_literal: true

require 'notification-renderer'

module NotificationPusher
  class ActionMailer
    require_relative 'action_mailer/engine'

    def initialize(notification, options = {})
      @notification = notification
      @options = options
    end

    def call
      ::NotificationPusher::ActionMailer::NotificationMailer.push(
        @notification, @options
      )
    end
  end
end
