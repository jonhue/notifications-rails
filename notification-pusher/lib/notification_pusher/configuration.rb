module NotificationPusher

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    class Configuration

        def define_pusher name, options = {}
            options[:name] = name
            ::NotificationPusher::Pusher.new options
        end

    end

end
