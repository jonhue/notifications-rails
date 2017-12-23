module NotificationHandler
    module NotificationLibrary

        attr_accessor :group

        before_validation :create_for_group

        private

        def create_for_group
            if self.group
                NotificationHandler::Group.find_by_name(self.group)&.each do |target|
                    notification = self.dup
                    notification.target = target
                    notification.group = nil
                    notification.save
                end
                return false
            end
        end

    end
end
