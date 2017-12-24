module NotificationPusher

    require 'notification_pusher/configuration'

    # require 'notification_pusher/engine'

    autoload :Pusher, 'notification_pusher/pusher'

    autoload :NotificationLibrary, 'notification_pusher/notification_library'

    require 'notification_pusher/railtie'

end
