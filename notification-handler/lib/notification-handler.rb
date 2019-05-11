# frozen_string_literal: true

module NotificationHandler
  require_relative 'notification_handler/configuration'

  require_relative 'notification_handler/engine'

  autoload :Group, 'notification_handler/group'

  autoload :Target, 'notification_handler/target'
  autoload :Object, 'notification_handler/object'
  autoload :NotificationLib, 'notification_handler/notification_lib'
  autoload :NotificationScopes, 'notification_handler/notification_scopes'
end
