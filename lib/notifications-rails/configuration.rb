module NotificationsRails
    class Configuration

        attr_accessor :default_type

        def initialize
            @default_type = 'notification'
        end

    end
end
