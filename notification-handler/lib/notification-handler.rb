# frozen_string_literal: true

module NotificationHandler
  require_relative 'notification_handler/configuration'

  require_relative 'notification_handler/engine'

  autoload :Group, 'notification_handler/group'

  autoload :Target, 'notification_handler/target'
  autoload :Object, 'notification_handler/object'
  autoload :NotificationLibrary, 'notification_handler/notification_library'
  autoload :NotificationScopes, 'notification_handler/notification_scopes'
end
