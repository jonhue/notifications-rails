module NotificationRenderer

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    class Configuration

        attr_accessor :placeholder

        def initialize
            @placeholder = true
        end

    end

end
