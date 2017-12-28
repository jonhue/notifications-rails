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
            options = default_options.merge! options
            if defined?(NotificationPusher.const_get(pusher.name))
                instance = NotificationPusher.const_get(self.name).new notification, options
                self.instances << instance
            end
        end

        def self.find_by_name name
            ObjectSpace.each_object(NotificationPusher::Pusher).select { |pusher| pusher.name == name }
        end

    end
end
