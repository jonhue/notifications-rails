# frozen_string_literal: true

module NotificationRenderer
  require_relative 'notification_renderer/configuration'

  require_relative 'notification_renderer/engine'

  autoload :NotificationLibrary, 'notification_renderer/notification_library'
  autoload :NotificationScopes, 'notification_renderer/notification_scopes'
end
