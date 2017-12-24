module NotificationHandler

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

        def define_group name, target_scope
            ::NotificationHandler::Group.new name: name.to_sym, target_scope: target_scope
        end

    end

end
