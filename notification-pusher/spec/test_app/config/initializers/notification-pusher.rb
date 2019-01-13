# frozen_string_literal: true

require 'notification_pusher/null'
require 'notification_pusher/some_pusher'

NotificationPusher.configure do |config|
  # A pusher handles the process of sending your notifications to various
  # services for you.
  # Learn more: https://github.com/jonhue/notifications-rails/tree/master/notification-pusher#pushers
  config.define_pusher :Null,       some_option: :value
  config.define_pusher :SomePusher, some_option: :value
end
