module NotificationPusher
    class Pusher

        attr_accessor :name
        attr_accessor :options
        attr_accessor :instances

        def instances
            @instances || []
        end

        def find_by_name name
            ObjectSpace.each_object(NotificationPusher::Pusher).select { |pusher| pusher.name == name }
        end

    end
end
