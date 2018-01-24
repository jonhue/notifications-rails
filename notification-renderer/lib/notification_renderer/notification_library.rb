require 'notification-handler'
require 'active_support'

module NotificationRenderer
    module NotificationLibrary

        extend ActiveSupport::Concern

        module ClassMethods

            def grouping group_by
                notifications = self
                group_by.each do |method|
                    notifications = recursive_grouping notifications, method
                end
                notifications
            end

            def grouping_by group_by
                self.group_by{ |notification| notification.send(group_by) }
            end

            def recursive_grouping notifications, group_by
                if notifications.is_a? Hash
                    notifications.each_pair do |k, v|
                        if v.is_a? Hash
                            recursive_grouping v, group_by
                        else
                            k = v.grouping_by group_by
                        end
                    end
                else
                    notifications.grouping_by group_by
                end
                notifications
            end

        end

        def type
            self[:type] || NotificationRenderer.configuration.default_type
        end

    end
end
