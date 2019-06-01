# frozen_string_literal: true

module NotificationRendererHelper
  def render_notification(notification,
                          renderer: default_renderer,
                          attributes: nil,
                          notifications: nil)
    notification.update(read: true) if auto_read
    render(
      partial: "notifications/#{notification.type}/#{renderer}",
      locals: {
        notification: notification,
        attributes: attributes,
        notifications: notifications
      }
    )
  end

  def render_notifications(notifications, renderer: default_renderer)
    content_tag :div, class: 'notification-renderer notifications' do
      notifications&.map do |notification|
        render_notification(notification, renderer: renderer)
      end
    end
  end

  def render_notifications_grouped(notifications, group_by,
                                   renderer: default_renderer,
                                   group_by_date: false,
                                   group_by_type: false)
    group_by.unshift(:type) if group_by_type
    if group_by_date
      group_by.unshift("created_at.beginning_of_#{group_by_date}")
    end

    content_tag :div, class: 'notification-renderer notifications' do
      recursive_notification_grouping(
        notifications.grouping(group_by), group_by, renderer
      )
    end
  end

  def notification_grouped?
    local_assigns[:attributes] && local_assigns[:notifications]
  end

  private

  def recursive_notification_grouping(notifications, group_by, renderer,
                                      attributes)
    i = 0
    notifications.each do |k, v|
      attributes[group_by[i]] = k
      i += 1
      recursive_render_notifications_grouped(v, renderer, attributes)
    end
  end

  def recursive_render_notifications_grouped(notifications, renderer,
                                             attributes)
    if notifications.is_a?(Hash)
      recursive_notification_grouping(
        notifications, group_by, renderer, attributes
      )
    else
      render_notification(notifications.last,
                          renderer: renderer,
                          attributes: attributes,
                          notifications: notifications)
    end
  end

  def auto_read
    NotificationRenderer.configuration.auto_read
  end

  def default_renderer
    NotificationRenderer.configuration.default_renderer
  end
end
