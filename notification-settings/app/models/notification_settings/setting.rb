# frozen_string_literal: true

module NotificationSettings
  class Setting < ActiveRecord::Base
    self.table_name = 'notification_settings_settings'

    include NotificationSettings::SettingLibrary

    serialize :settings, Hash
    serialize :category_settings, Hash

    belongs_to :object, polymorphic: true, optional: true
    belongs_to :subscription, optional: true
  end
end
