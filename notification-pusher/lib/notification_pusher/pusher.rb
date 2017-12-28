module NotificationPusher
    class Pusher

        attr_accessor :name
        attr_accessor :options
        attr_accessor :instances

        def initialize name, options = {}
            @instances = []
            @name = name
            @options = options
        end

        def push notification, options = {}
            default_options = self.options
            options = options.nil? ? default_options : default_options.merge!(options)
            if defined?(NotificationPusher.const_get(self.name))
                instance = NotificationPusher.const_get(self.name).new notification, options
                self.instances << instance
            end
        end

        def self.find_by_name name
            NotificationPusher.configuration.pushers.select { |pusher| pusher.name == name }
        end

    end
end
