require 'notification-handler'
require 'active_support'

module NotificationRenderer
    module NotificationLibrary

        extend ActiveSupport::Concern

        included do
            include NotificationRenderer::NotificationLibrary::InstanceMethods
        end

        module InstanceMethods

            def self.grouping group_by
                group_by{ |notification| notification.send(group_by) }
            end

            def type
                self[:type] || NotificationRenderer.configuration.default_type
            end

        end

    end
end
