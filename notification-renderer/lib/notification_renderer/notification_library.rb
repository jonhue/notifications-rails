module NotificationRenderer
    module NotificationLibrary

        def self.grouping group_by
            group_by{ |notification| notification.send(group_by) }
        end

    end
end
