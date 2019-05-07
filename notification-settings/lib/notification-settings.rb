# frozen_string_literal: true

module NotificationSettings
  require_relative 'notification_settings/configuration'

  require_relative 'notification_settings/engine'

  autoload :Target, 'notification_settings/target'
  autoload :Subscriber, 'notification_settings/subscriber'
  autoload :Subscribable, 'notification_settings/subscribable'
  autoload :SettingLibrary, 'notification_settings/setting_library'
  autoload :NotificationLibrary, 'notification_settings/notification_library'
  autoload :NotificationScopes, 'notification_settings/notification_scopes'
end
