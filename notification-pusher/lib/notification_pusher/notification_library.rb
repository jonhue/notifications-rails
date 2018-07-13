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
        self.pusher = name
        self.pusher_options = options
        initialize_pusher
      end

      private

      def initialize_pusher
        return if pusher.nil?

        if pusher.is_a?(Array)
          pusher.each do |class_name|
            initiate_push(class_name, pusher_options[class_name.to_sym])
          end
        else
          initiate_push(pusher, pusher_options)
        end
      end

      def initiate_push(class_name, options = {})
        pusher = NotificationPusher::Pusher.find_by_name(class_name).first
        pusher.push(self, options)
      end
    end
  end
end
