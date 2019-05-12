# frozen_string_literal: true

module NotificationPusher
  require_relative 'notification_pusher/configuration'

  require_relative 'notification_pusher/delivery_method/base'

  autoload :DeliveryMethodConfiguration,
           'notification_pusher/delivery_method_configuration'
  autoload :NotificationLib, 'notification_pusher/notification_lib'
end
