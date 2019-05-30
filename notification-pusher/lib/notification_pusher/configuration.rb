# frozen_string_literal: true

require_relative 'delivery_method_configuration'

module NotificationPusher
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :delivery_methods

    def initialize
      @delivery_methods = {}
    end

    def register_delivery_method(name, class_name, options = {})
      delivery_methods[name.to_sym] =
        ::NotificationPusher::DeliveryMethodConfiguration
        .new(class_name, options)
    end
  end
end
