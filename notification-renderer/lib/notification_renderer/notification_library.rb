module NotificationRenderer
    module NotificationLibrary

        def self.grouping group_by
            group_by{ |notification| notification.send(group_by) }
        end

        def type
            self[:type] || NotificationRenderer.configuration.default_type
        end

    end
end
