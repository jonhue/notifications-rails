module NotificationHandler

    require 'notification_handler/configuration'

    autoload :Group, 'notification_handler/group'

    autoload :Target, 'notification_handler/target'
    autoload :Object, 'notification_handler/object'
    autoload :NotificationLibrary, 'notification_handler/notification_library'
    autoload :NotificationScopes, 'notification_handler/notification_scopes'

    require 'notification_handler/railtie'

end
