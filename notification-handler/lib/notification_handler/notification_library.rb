require 'active_support'

module NotificationHandler
    module NotificationLibrary

        extend ActiveSupport::Concern

        included do
            before_validation :create_for_group
            after_commit :cache

            serialize :metadata, Hash
            attr_accessor :group

            belongs_to :target, polymorphic: true
            belongs_to :object, polymorphic: true, optional: true

            include NotificationHandler::NotificationLibrary::InstanceMethods

            include NotificationRenderer::NotificationLibrary if defined?(NotificationRenderer)
            include NotificationPusher::NotificationLibrary if defined?(NotificationPusher)
            include NotificationSettings::NotificationLibrary if defined?(NotificationSettings)
        end

        module InstanceMethods

            def read?
                self.read
            end
            def unread?
                !self.read
            end

            private

            def create_for_group
                unless self.group.nil?
                    target_scope = NotificationHandler::Group.find_by_name(self.group).last.target_scope
                    target_scope&.each do |target|
                        notification = self.dup
                        notification.target = target
                        notification.group = nil
                        notification.save
                    end
                    return false
                end
            end

            def cache
                if self.read_changed?
                    self.target.read_notification_count = self.target.notifications.read.count
                    self.target.unread_notification_count = self.target.notifications.unread.count
                    self.target.save!
                end
            end

        end

    end
end
