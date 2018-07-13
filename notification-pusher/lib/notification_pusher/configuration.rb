# frozen_string_literal: true

module NotificationPusher
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
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
