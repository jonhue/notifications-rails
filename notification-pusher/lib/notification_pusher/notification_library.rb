# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationPusher
  module NotificationLibrary
    extend ActiveSupport::Concern

    included do
      attr_accessor :pusher
      attr_accessor :pusher_options

      after_create_commit :initialize_pusher

      include NotificationPusher::NotificationLibrary::InstanceMethods
    end

    module InstanceMethods
      def push(name, options = {})
        pusher = name
        pusher_options = options
        initialize_pusher
      end

      private

      def initialize_pusher
        return if pusher.nil?
        if pusher.is_a?(Array)
          pusher.each do |class_name|
            pusher = NotificationPusher::Pusher.find_by_name(class_name).first
            pusher.push(self, pusher_options[class_name.to_sym])
          end
        else
          pusher = NotificationPusher::Pusher.find_by_name(pusher).first
          pusher.push(self, pusher_options)
        end
      end
    end
  end
end
