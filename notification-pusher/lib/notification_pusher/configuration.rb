# frozen_string_literal: true

require_relative 'pusher'

module NotificationPusher
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
    attr_accessor :pushers

    def initialize
      @pushers = []
    end

    def define_pusher(name, options = {})
      pushers << ::NotificationPusher::Pusher.new(name, options)
    end
  end
end
