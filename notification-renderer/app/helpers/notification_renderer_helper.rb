module NotificationRendererHelper

    def render_notification notification, options = {}
        defaults = {
            renderer: NotificationRenderer.configuration.default_renderer,
            attributes: nil,
            notifications: nil
        }
        options = defaults.merge options

        notification.update_attributes read: true if NotificationRenderer.configuration.auto_read
        render partial: "notifications/#{notification.type}/#{options[:renderer]}", locals: { notification: notification, attributes: options[:attributes], notifications: options[:notifications] }
    end

    def render_notifications notifications, options = {}
        defaults = {
            renderer: NotificationRenderer.configuration.default_renderer
        }
        options = defaults.merge options

        content_tag :div, class: 'notification-renderer notifications' do
            notifications.each do |notification|
                render_notification notification, renderer: options[:renderer]
            end
        end
    end

    def render_notifications_grouped notifications, group_by, options = {}
        defaults = {
            renderer: NotificationRenderer.configuration.default_renderer,
            group_by_date: false,
            group_by_type: false
        }
        options = defaults.merge options

        group_by.unshift :type if options[:group_by_type]
        group_by.unshift "created_at.beginning_of_#{options[:group_by_date]}" if options[:group_by_date]

        content_tag :div, class: 'notification-renderer notifications' do
            recursive_render_notifications_grouped notifications.grouping(options[:group_by]), options
        end
    end

    def notification_grouped?
        local_assigns[:attributes] && local_assigns[:notifications]
    end

    private

    def recursive_render_notifications_grouped notifications, i = 0, options = {}
        options[:attributes] = {} unless options.has_key? :attributes
        notifications.each_pair do |k, v|
            options[:attributes][options[:group_by][i]] = k
            i += 1
            if v.is_a? Hash
                recursive_render_notifications_grouped v, options
            else
                render_notification v.last, renderer: options[:renderer], attributes: options[:attributes], notifications: v
            end
        end
    end

end
