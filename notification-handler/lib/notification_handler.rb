module NotificationHandler

    require 'notification_handler/configuration'

    # require 'notification_handler/engine'

    autoload :Target, 'notification_handler/target'
    autoload :Object, 'notification_handler/object'
    autoload :Library, 'notification_handler/library'
    autoload :Scopes, 'notification_handler/scopes'

    require 'notification_handler/railtie'

end
