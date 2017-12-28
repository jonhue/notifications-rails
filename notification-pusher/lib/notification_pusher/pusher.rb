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

        def find_by_name name
            ObjectSpace.each_object(NotificationPusher::Pusher).select { |pusher| pusher.name == name }
        end

    end
end
