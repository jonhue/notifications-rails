module NotificationRendererHelper

    def render_notification notification, renderer = NotificationRenderer.configuration.default_renderer
        notification.update_attributes read: true
        render "notifications/#{notification.type}/#{renderer}", notification: notification
    end

    def render_notifications notifications, renderer = NotificationRenderer.configuration.default_renderer
        content_tag :div, class: 'notification-renderer notifications' do
            notifications.each do |notification|
                render_notification notification, renderer
            end
        end
    end

    def render_notifications_grouped notifications, group_by, renderer = NotificationRenderer.configuration.default_renderer
        content_tag :div, class: 'notification-renderer notifications' do
            notifications.grouping(group_by)&.each do |attribute, notifications|
                render_notification_grouped notifications.last, attribute, notifications.count, renderer
            end
        end
    end

    def notification_grouped?
        local_assigns[:attribute]
    end

    private

    def render_notification_grouped notification, attribute, notifications_count, renderer = NotificationRenderer.configuration.default_renderer
        notification.update_attributes read: true
        render "notifications/#{notification.type}/#{renderer}", notification: notification, attribute: attribute, notifications_count: notifications_count
    end

end
