# frozen_string_literal: true

require_relative 'notification_pusher/configuration'
require_relative 'notification_pusher/delivery_method/base'

module NotificationPusher
  autoload :DeliveryMethodConfiguration, 'notification_pusher/delivery_method_configuration'
  autoload :NotificationLib, 'notification_pusher/notification_lib'
end
