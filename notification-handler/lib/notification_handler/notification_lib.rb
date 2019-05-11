# frozen_string_literal: true

require 'active_support'

module NotificationHandler
  module NotificationLib
    extend ActiveSupport::Concern

    included do
      self.inheritance_column = :_type_disabled

      before_validation :create_for_group
      after_commit :cache

      serialize :metadata, Hash
      attr_accessor :group

      belongs_to :target, polymorphic: true
      belongs_to :object, polymorphic: true, optional: true

      include NotificationHandler::NotificationLib::InstanceMethods

      if defined?(NotificationRenderer)
        include NotificationRenderer::NotificationLib
      end
      if defined?(NotificationPusher)
        include NotificationPusher::NotificationLib
      end
      if defined?(NotificationSettings)
        include NotificationSettings::NotificationLib
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

        target_scope = NotificationHandler::Group.find_by_name!(group)
                                                 .target_scope
        target_scope.call&.each_with_index do |target, index|
          notification = index.zero? ? self : dup
          notification.target = target
          notification.group = nil
          notification.save!
        end
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
