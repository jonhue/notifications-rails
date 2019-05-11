# frozen_string_literal: true

module NotificationPusher
  class DeliveryMethodConfiguration
    attr_reader :name

    def initialize(name, options = {})
      @instances = []
      @name = name
      @options = options
    end

    def call(notification, options = {})
      options = @options.merge!(options)

      instance = NotificationPusher::DeliveryMethod.const_get(@name).new(notification, options)
      instance.call
      @instances << instance
    end

    def self.find_by_name(name)
      NotificationPusher.configuration.delivery_methods.find do |delivery_method|
        delivery_method.name == name
      end
    end

    def self.find_by_name!(name)
      find_by_name(name) ||
        raise(ArgumentError,
              "Could not find a registered delivery_method for #{name}. " \
              "Make sure you register it with config.register_delivery_method :#{name}")
    end
  end
end
