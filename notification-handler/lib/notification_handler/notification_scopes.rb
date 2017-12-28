module NotificationHandler
    module NotificationScopes

        extend ActiveSupport::Concern

        included do
            scope :read, -> { where(read: true) }
            scope :unread, -> { where(read: false) }

            include NotificationRenderer::NotificationScopes if defined?(NotificationRenderer)
            include NotificationSettings::NotificationScopes if defined?(NotificationSettings)
        end

    end
end
