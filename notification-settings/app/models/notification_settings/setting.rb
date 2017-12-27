class NotificationSettings::Setting < ActiveRecord::Base

    self.table_name = 'notification_settings_settings'

    extend NotificationSettings::SettingLibrary
    
    serialize :settings, Hash
    serialize :category_settings, Hash

    belongs_to :object, polymorphic: true

end
