# frozen_string_literal: true

module NotificationPusher
  require_relative 'notification_pusher/configuration'

  autoload :Pusher, 'notification_pusher/pusher'

  autoload :NotificationLib, 'notification_pusher/notification_lib'
end
