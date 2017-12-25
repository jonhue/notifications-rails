module NotificationHandler
    module NotificationLibrary

        attr_accessor :group

        before_validation :create_for_group
        after_commit :cache

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
