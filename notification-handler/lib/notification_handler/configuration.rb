# frozen_string_literal: true

require_relative 'group'

module NotificationHandler
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
    attr_accessor :cache, :groups

    def initialize
      @groups = {}
      @cache = false
    end

    def define_group(name, target_scope)
      groups[name.to_sym] = ::NotificationHandler::Group.new(target_scope)
    end
  end
end
