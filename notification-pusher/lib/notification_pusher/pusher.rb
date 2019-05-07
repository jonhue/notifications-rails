# frozen_string_literal: true

module NotificationPusher
  class Pusher
    attr_reader :name

    def initialize(name, options = {})
      @instances = []
      @name = name
      @options = options
    end

    def call(notification, options = {})
      options = @options.merge!(options)

      return unless defined?(NotificationPusher.const_get(@name))

      instance = NotificationPusher.const_get(@name).new(notification, options)
      instance.call
      @instances << instance
    end

    def self.find_by_name(name)
      NotificationPusher.configuration.pushers.find do |pusher|
        pusher.name == name
      end
    end

    def self.find_by_name!(name)
      find_by_name(name) ||
        raise(ArgumentError,
              "Could not find a registered pusher for #{name}. " \
              "Make sure you register it with config.define_pusher :#{name}")
    end
  end
end
