module NotificationRendererHelper

    def render_notification notification, renderer = 'index'
        render "notifications/#{notification.type}/#{renderer}"
    end

    def render_notifications notifications, renderer = 'index'
        content_tag :div, class: 'notification-renderer notifications' do
            notifications.each do |notification|
                render_notification notification, renderer
            end
        end
    end

end
