# frozen_string_literal: true

require 'notification-renderer'

module NotificationPusher
  class ActionCable
    require 'notification_pusher/action_cable/engine'

    def initialize(notification, options = {})
      @notification = notification
      @options = options
    end

    def call
      # ...
    end
  end
end
