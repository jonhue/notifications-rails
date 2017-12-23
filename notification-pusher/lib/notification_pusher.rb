module NotificationPusher

    require 'notification_pusher/configuration'

    # require 'notification_pusher/engine'

    autoload :NotificationLibrary, 'notification_pusher/notification_library'

    require 'notification_pusher/railtie'

end
