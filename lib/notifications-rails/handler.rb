module NotificationsRails
    module Handler

        autoload :NotificationTarget, 'handler/notification_target'
        autoload :NotificationObject, 'handler/notification_object'
        autoload :NotificationLib, 'handler/notification_lib'
        autoload :NotificationScopes, 'handler/notification_scopes'

        require 'handler/railtie'

    end
end
