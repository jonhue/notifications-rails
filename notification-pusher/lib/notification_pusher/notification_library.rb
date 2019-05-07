# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationPusher
  module NotificationLibrary
    extend ActiveSupport::Concern

    included do
      attr_accessor :pusher
      attr_accessor :pusher_options

      after_create_commit :push_after_create_commit

      include NotificationPusher::NotificationLibrary::InstanceMethods
    end

    module InstanceMethods
      def push(pushers, pusher_options = {})
        return unless pushers
        return push!(pushers, pusher_options) unless pushers.is_a?(Array)

        pushers.each do |pusher|
          push(pusher, pusher_options[pusher.to_sym] || {})
        end
      end

      def push!(class_name, options = {})
        pusher = NotificationPusher::Pusher.find_by_name!(class_name)
        pusher.call(self, options)
      end

      private

      # If pusher attribute was specified when object was built/created,
      # push using that pusher
      def push_after_create_commit
        return if pusher.nil?

        push(pusher, pusher_options || {})
      end
    end
  end
end
