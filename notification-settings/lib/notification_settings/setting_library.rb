module NotificationSettings
    module SettingLibrary

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
