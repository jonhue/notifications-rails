# frozen_string_literal: true

module NotificationRenderer
  class << self
    attr_accessor :configuration
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @@configuration ||= Configuration.new
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
