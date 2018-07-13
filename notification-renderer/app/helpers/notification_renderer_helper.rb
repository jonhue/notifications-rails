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
      notifications&.each do |notification|
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
      recursive_render_notifications_grouped(
        notifications.grouping(group_by), group_by,
        renderer: renderer
      )
    end
  end

  def notification_grouped?
    local_assigns[:attributes] && local_assigns[:notifications]
  end

  private

  def recursive_render_notifications_grouped(notifications, group_by, iter = 0,
                                             renderer: default_renderer,
                                             attributes: {})
    notifications.each_pair do |k, v|
      attributes[group_by[iter]] = k
      iter += 1
      if v.is_a?(Hash)
        recursive_render_notifications_grouped(
          v, group_by, renderer: renderer, attributes: attributes
        )
      else
        render_notification(
          v.last,
          renderer: renderer,
          attributes: attributes,
          notifications: v
        )
      end
    end
  end

  def auto_read
    NotificationRenderer.configuration.auto_read
  end

  def default_renderer
    NotificationRenderer.configuration.default_renderer
  end
end
