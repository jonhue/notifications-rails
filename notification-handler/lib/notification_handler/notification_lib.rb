# frozen_string_literal: true

require 'active_support'

module NotificationHandler
  module NotificationLib
    extend ActiveSupport::Concern

    included do
      self.inheritance_column = :_type_disabled

      after_commit :cache

      serialize :metadata, Hash

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

    module ClassMethods
      def for_group(group, args: [], attrs: {})
        return if group.nil?

        target_scope = NotificationHandler::Group.find_by_name!(group)
                                                 .target_scope
        target_scope.call(*args)&.map do |target|
          Notification.create(attrs.merge(target: target))
        end
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

      def cache
        return unless read_changed?

        target.read_notification_count = target.notifications.read.size
        target.unread_notification_count = target.notifications.unread.size
        target.save!
      end
    end
  end
end
