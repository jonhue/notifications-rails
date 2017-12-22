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

    # class Engine < ::Rails::Engine
    # end

    require 'notifications-rails/handler'
    require 'notifications-rails/pusher'
    require 'notifications-rails/settings'

end
