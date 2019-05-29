# frozen_string_literal: true

require 'notification_pusher/delivery_method/null'
require 'notification_pusher/delivery_method/some_pusher'

NotificationPusher.configure do |config|
  # A delivery method handles the process of sending your notifications to
  # various services for you.
  # Learn more: https://github.com/jonhue/notifications-rails/tree/master/notification-pusher#delivery-methods
  config.register_delivery_method :null,        :Null,       some_option: :value
  config.register_delivery_method :some_pusher, :SomePusher, some_option: :value
end
