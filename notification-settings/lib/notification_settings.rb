module NotificationSettings

    require 'notification_settings/configuration'

    require 'notification_settings/engine'

    autoload :Target, 'notification_settings/target'
    autoload :Subscriber, 'notification_settings/subscriber'
    autoload :Subscribable, 'notification_settings/subscribable'
    autoload :SettingLibrary, 'notification_settings/setting_library'
    autoload :SubscriptionLibrary, 'notification_settings/subscription_library'
    autoload :NotificationLibrary, 'notification_settings/notification_library'
    autoload :NotificationScopes, 'notification_settings/notification_scopes'

    require 'notification_settings/railtie'

end
