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
    attr_accessor :default_type
    attr_accessor :default_renderer
    attr_accessor :auto_read

    def initialize
      @default_type = 'notification'
      @default_renderer = 'index'
      @auto_read = true
    end
  end
end
