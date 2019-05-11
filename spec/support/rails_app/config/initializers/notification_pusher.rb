# frozen_string_literal: true

require 'notification_pusher/delivery_method/null'
require 'notification_pusher/delivery_method/some_pusher'

NotificationPusher.configure do |config|
  # A pusher handles the process of sending your notifications to various
  # services for you.
  # Learn more: https://github.com/jonhue/notifications-rails/tree/master/notification-pusher#pushers
  config.register_delivery_method :Null,       some_option: :value
  config.register_delivery_method :SomePusher, some_option: :value
end
