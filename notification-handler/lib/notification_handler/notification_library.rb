# frozen_string_literal: true

require 'active_support'

module NotificationHandler
  module NotificationLibrary
    extend ActiveSupport::Concern

    included do
      self.inheritance_column = :_type_disabled

      before_validation :create_for_group
      after_commit :cache

      serialize :metadata, Hash
      attr_accessor :group

      belongs_to :target, polymorphic: true
      belongs_to :object, polymorphic: true, optional: true

      include NotificationHandler::NotificationLibrary::InstanceMethods

      if defined?(NotificationRenderer)
        include NotificationRenderer::NotificationLibrary
      end
      if defined?(NotificationPusher)
        include NotificationPusher::NotificationLibrary
      end
      if defined?(NotificationSettings)
        include NotificationSettings::NotificationLibrary
      end
    end

    module InstanceMethods
      def read?
        read
      end

      def unread?
        !read
      end

      private

      def create_for_group
        return if group.nil?

        target_scope = NotificationHandler::Group.find_by_name(group)
                                                 .last.target_scope
        target_scope.call&.each do |target|
          notification = dup
          notification.target = target
          notification.group = nil
          notification.save
        end
        false
      end

      def cache
        return unless read_changed?

        target.read_notification_count = target.notifications.read.count
        target.unread_notification_count = target.notifications.unread.count
        target.save!
      end
    end
  end
end
