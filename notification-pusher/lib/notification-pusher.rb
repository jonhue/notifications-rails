# frozen_string_literal: true

module NotificationPusher
  require 'notification_pusher/configuration'

  autoload :Pusher, 'notification_pusher/pusher'

  autoload :NotificationLibrary, 'notification_pusher/notification_library'
end
