module NotificationPusher

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    class Configuration

        attr_accessor :pushers

        def initialize
            @pushers = []
        end

        def define_pusher name, options = {}
            self.pushers << ::NotificationPusher::Pusher.new name, options
        end

    end

end
