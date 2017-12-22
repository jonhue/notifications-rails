require 'notifications-rails/version'

module NotificationsRails

    autoload :Configuration, 'notifications-rails/configuration'

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    autoload :NotificationTarget, 'notifications-rails/notification_target'
    autoload :NotificationObject, 'notifications-rails/notification_object'
    autoload :NotificationLib, 'notifications-rails/notification_lib'
    autoload :NotificationScopes, 'notifications-rails/notification_scopes'

    require 'notifications-rails/railtie'

    # class Engine < ::Rails::Engine
    # end

end
