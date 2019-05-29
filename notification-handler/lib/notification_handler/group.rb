# frozen_string_literal: true

module NotificationHandler
  class Group
    attr_reader :target_scope

    def initialize(target_scope)
      @target_scope = target_scope
    end

    def self.find_by_name(name)
      NotificationHandler.configuration.groups[name]
    end

    def self.find_by_name!(name)
      find_by_name(name) ||
        raise(ArgumentError,
              "Could not find a registered group for #{name}. " \
              "Make sure you register it with config.define_group :#{name}")
    end
  end
end
