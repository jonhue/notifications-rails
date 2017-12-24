class NotificationSettings::Setting < ActiveRecord::Base

    self.table_name = 'notification_settings_settings'

    extend NotificationSettings::SettingLibrary

    belongs_to :object, polymorphic: true

end
