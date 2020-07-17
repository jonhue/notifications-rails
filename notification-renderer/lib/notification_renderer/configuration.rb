# frozen_string_literal: true

module NotificationRenderer
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
    attr_accessor :auto_read, :default_renderer, :default_type

    def initialize
      @default_type = 'notification'
      @default_renderer = 'index'
      @auto_read = true
    end
  end
end
