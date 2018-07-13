# frozen_string_literal: true

module NotificationSettings
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :default_category
    attr_accessor :last_seen
    attr_accessor :idle_after
    attr_accessor :offline_after
    attr_accessor :do_not_notify_statuses
    attr_accessor :do_not_push_statuses

    def initialize
      @default_category = 'notification'
      @last_seen = 'last_seen'
      @idle_after = 10.minutes
      @offline_after = 3.hours
      @do_not_notify_statuses = []
      @do_not_push_statuses = ['do not disturb']
    end
  end
end
