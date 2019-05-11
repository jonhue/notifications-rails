# frozen_string_literal: true

module NotificationSettings
  class Subscription < ActiveRecord::Base
    self.table_name = 'notification_settings_subscriptions'

    after_create_commit :create_notification_setting!

    belongs_to :subscriber, polymorphic: true
    belongs_to :subscribable, polymorphic: true

    has_many :notifications, class_name: '::Notification'
    has_one :notification_setting, class_name: 'Setting'
  end
end
