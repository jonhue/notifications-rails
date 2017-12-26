module NotificationRendererHelper

    def render_notification notification, renderer = NotificationRenderer.configuration.default_renderer, attribute, notifications_count
        notification.update_attributes read: true if NotificationRenderer.configuration.auto_read
        render "notifications/#{notification.type}/#{renderer}", notification: notification, attribute: attribute, notifications_count: notifications_count
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
                render_notification notifications.last, renderer, attribute, notifications.count
            end
        end
    end

    def notification_grouped?
        local_assigns[:attribute]
    end

end
