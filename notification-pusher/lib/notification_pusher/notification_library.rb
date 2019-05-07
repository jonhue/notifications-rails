# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationPusher
  module NotificationLibrary
    extend ActiveSupport::Concern

    included do
      attr_accessor :pusher
      attr_accessor :pusher_options

      after_create_commit :push_using_pusher_from_attributes

      include NotificationPusher::NotificationLibrary::InstanceMethods
    end

    module InstanceMethods
      def push(pushers, pusher_options = {})
        unless pushers
          raise ArgumentError, 'Expected a pusher or array of pushers but got nil'
        end
        if pushers.is_a?(Array)
          pushers.each do |pusher|
            push(pusher, pusher_options[pusher.to_sym] || {})
          end
        else
          push!(pushers, pusher_options)
        end
      end

      def push!(class_name, options = {})
        pusher = NotificationPusher::Pusher.find_by_name!(class_name)
        pusher.call(self, options)
      end

      private

      # If pusher attribute was specified when object was built/created, push using that pusher
      def push_using_pusher_from_attributes
        return if pusher.nil?
        push(pusher, pusher_options || {})
      end
    end
  end
end
