# frozen_string_literal: true

module NotificationSettings
  require_relative 'notification_settings/configuration'

  require_relative 'notification_settings/engine'

  autoload :Target, 'notification_settings/target'
  autoload :Subscriber, 'notification_settings/subscriber'
  autoload :Subscribable, 'notification_settings/subscribable'
  autoload :Settings, 'notification_settings/settings'
  autoload :Status, 'notification_settings/status'
  autoload :NotificationLib, 'notification_settings/notification_lib'
  autoload :NotificationScopes, 'notification_settings/notification_scopes'
  autoload :CategoryPreferencesForm,
           'notification_settings/category_preferences_form'
  autoload :DeliveryMethodPreferencesForm,
           'notification_settings/delivery_method_preferences_form'
  autoload :PreferencesForm, 'notification_settings/preferences_form'
end
