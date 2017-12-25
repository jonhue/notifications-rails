module NotificationRendererHelper

    def render_notification notification, template = 'index'
        render "notifications/#{notification.type}/#{template}"
    end

    def render_notifications notifications, template = 'index'
        content_tag :div, class: 'notification-renderer notifications' do
            notifications.each do |notification|
                render_notification notification, template
            end
        end
    end

end
