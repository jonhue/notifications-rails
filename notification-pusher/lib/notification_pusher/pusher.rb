# frozen_string_literal: true

module NotificationPusher
  class Pusher
    attr_reader :name

    def initialize name, options = {}
      @instances = []
      @name = name
      @options = options
    end

    def push(notification, options = {})
      options = @options.merge!(options)

      return unless defined?(NotificationPusher.const_get(@name))
      instance = NotificationPusher.const_get(@name).new(notification, options)
      @instances << instance
    end

    def self.find_by_name(name)
      NotificationPusher.configuration.pushers.select do |pusher|
        pusher.name == name
      end
    end
  end
end
