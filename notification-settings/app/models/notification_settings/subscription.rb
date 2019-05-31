# frozen_string_literal: true

module NotificationSettings
  class Subscription < ActiveRecord::Base
    self.table_name = 'notification_settings_subscriptions'

    include NotificationSettings::Settings

    belongs_to :subscriber, polymorphic: true
    belongs_to :subscribable, polymorphic: true

    has_many :notifications, class_name: '::Notification'
  end
end
