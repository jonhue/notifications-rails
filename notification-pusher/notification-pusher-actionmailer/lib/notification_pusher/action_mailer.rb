# frozen_string_literal: true

require 'notification-renderer'

module NotificationPusher
  class ActionMailer
    require 'notification_pusher/action_mailer/engine'

    def initialize(notification, options = {})
      ::NotificationPusher::ActionMailer::NotificationMailer.push(
        notification, options
      )
    end
  end
end
