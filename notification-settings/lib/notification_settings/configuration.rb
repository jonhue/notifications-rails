# frozen_string_literal: true

module NotificationSettings
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
    attr_accessor :categories, :default_category, :do_not_deliver_statuses, :do_not_notify_statuses, :idle_after,
                  :last_seen, :offline_after, :statuses

    def initialize
      @categories = [:notification]
      @default_category = :notification
      @last_seen = :last_seen
      @idle_after = 10.minutes
      @offline_after = 3.hours
      @statuses = ['online', 'idle', 'offline', 'do not notify',
                   'do not disturb']
      @do_not_notify_statuses = ['do not notify']
      @do_not_deliver_statuses = ['do not disturb']
    end
  end
end
