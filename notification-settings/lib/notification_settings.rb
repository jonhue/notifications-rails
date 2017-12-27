module NotificationSettings

    require 'notification_settings/configuration'

    require 'notification_settings/engine'

    autoload :Object, 'notification_settings/object'
    autoload :SettingLibrary, 'notification_settings/setting_library'
    autoload :SubscriptionLibrary, 'notification_settings/subscription_library'
    autoload :NotificationLibrary, 'notification_settings/notification_library'

    require 'notification_settings/railtie'

end
