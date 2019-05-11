# frozen_string_literal: true

require_relative 'pusher'

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
    attr_accessor :pushers

    def initialize
      @pushers = []
    end

    def define_pusher(name, options = {})
      pushers << ::NotificationPusher::Pusher.new(name, options)
    end
  end
end
