# frozen_string_literal: true

module NotificationHandler
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :groups
    attr_accessor :cache

    def initialize
      @groups = []
      @cache = false
    end

    def define_group(name, target_scope)
      groups << ::NotificationHandler::Group.new(name.to_sym, target_scope)
    end
  end
end
