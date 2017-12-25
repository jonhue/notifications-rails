module NotificationRenderer

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    class Configuration

        attr_accessor :default_type
        attr_accessor :default_renderer

        def initialize
            @default_type = 'notification'
            @default_renderer = 'index'
        end

    end

end
