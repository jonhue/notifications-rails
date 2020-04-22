# frozen_string_literal: true

require_relative '../rails_helper'

def create_title_and_content_notification(title, content)
  Notification.create(type: 'title_and_content',
                      metadata: { title: title, content: content })
end

notification1 = create_title_and_content_notification('title1', 'content1')
notification2 = create_title_and_content_notification('title2', 'content2')
notifications = [notification1, notification2]

RSpec.describe NotificationRendererHelper, type: :helper do
  describe 'render_notification' do
    it 'renders notification using default renderer' do
      rendered = helper.render_notification(notification1)

      expect(rendered).to eq("<div>\ntitle1: content1\n\n\n</div>")
    end

    it 'renders notification using custom renderer' do
      rendered = helper.render_notification(notification1, renderer: 'custom')

      expect(rendered).to eq('<div>Custom notification: title1: content1</div>')
    end

    it 'renders notification with attributes' do
      attributes = { key1: 'value1', key2: 'value2' }

      rendered = helper.render_notification(notification1,
                                            attributes: attributes)

      expect(rendered).to eq(
        "<div>\n" \
        "title1: content1\n" \
        'attributes: ' \
        "{:key1=&gt;&quot;value1&quot;, :key2=&gt;&quot;value2&quot;}\n\n" \
        '</div>'
      )
    end

    it 'renders notification with notifications' do
      rendered = helper.render_notification(notification1,
                                            notifications: notifications)

      expect(rendered).to eq(
        "<div>\n" \
        "title1: content1\n\n" \
        "notifications count: #{notifications.length}\n" \
        '</div>'
      )
    end

    it 'mark notification as read when auto_read is enabled' do
      test_auto_read(true)
    end

    it 'dont mark notification as read when auto_read is disabled' do
      test_auto_read(false)
    end

    def test_auto_read(expected)
      NotificationRenderer.configuration.auto_read = expected

      notification = create_title_and_content_notification('title1', 'content1')

      expect(notification.read?).to be false

      helper.render_notification(notification)

      expect(notification.read?).to be expected
    end
  end

  describe 'render_notifications' do
    it 'renders notifications using default renderer' do
      rendered = helper.render_notifications(notifications)

      expect(rendered).to eq(rendered_notifications(notifications))
    end

    it 'renders notifications using custom renderer' do
      rendered = helper.render_notifications(notifications, renderer: 'custom')

      expect(rendered).to eq(rendered_notifications(notifications,
                                                    renderer: 'custom'))
    end
  end
end

def rendered_notifications(notifications, renderer: default_renderer)
  content_tag :div, class: 'notification-renderer notifications' do
    notifications&.map do |notification|
      concat render_notification(notification, renderer: renderer)
    end
  end
end
