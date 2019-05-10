# frozen_string_literal: true

module NotificationRenderer
  require_relative 'notification_renderer/configuration'

  require_relative 'notification_renderer/engine'

  autoload :NotificationLib, 'notification_renderer/notification_lib'
  autoload :NotificationScopes, 'notification_renderer/notification_scopes'
end
