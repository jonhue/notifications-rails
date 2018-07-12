# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module SettingLibrary
    extend ActiveSupport::Concern

    included do
      include NotificationSettings::SettingLibrary::InstanceMethods
    end

    module InstanceMethods
      def status
        if self.object.respond_to?(NotificationSettings.configuration.last_seen) && ( Time.now - self.object.send(NotificationSettings.configuration.last_seen) ).round >= NotificationSettings.configuration.idle_after && ( Time.now - self.object.send(NotificationSettings.configuration.last_seen) ).round < NotificationSettings.configuration.offline_after
          default = 'idle'
        elsif self.object.respond_to?(NotificationSettings.configuration.last_seen) && ( Time.now - self.object.send(NotificationSettings.configuration.last_seen) ).round >= NotificationSettings.configuration.offline_after
          default = 'offline'
        else
          'online'
        end
        self[:status] || default
      end
    end
  end
end
