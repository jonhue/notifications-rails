# frozen_string_literal: true

module NotificationHandler
  class Group
    attr_accessor :name
    attr_accessor :target_scope

    def initialize(name, target_scope)
      @name = name
      @target_scope = target_scope
    end

    def self.find_by_name(name)
      NotificationHandler.configuration.groups.find do |group|
        group.name == name.to_sym
      end
    end

    def self.find_by_name!(name)
      find_by_name(name) ||
        raise(ArgumentError,
              "Could not find a registered group for #{name}. " \
              "Make sure you register it with config.define_group :#{name}")
    end
  end
end
