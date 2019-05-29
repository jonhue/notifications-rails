# frozen_string_literal: true

module NotificationPusher
  class DeliveryMethodConfiguration
    def initialize(class_name, options = {})
      @klass = NotificationPusher::DeliveryMethod.const_get(class_name)
      @options = options
    end

    def call(notification, options = {})
      options = @options.merge!(options)

      @klass.new(notification, options).call
    end

    def self.find_by_name(name)
      NotificationPusher.configuration.delivery_methods[name]
    end

    def self.find_by_name!(name)
      find_by_name(name) ||
        raise(ArgumentError,
              "Could not find a registered delivery method for :#{name}. " \
              'Make sure you register it with ' \
              "config.register_delivery_method :#{name}, :CustomDeliveryMethod")
    end
  end
end
