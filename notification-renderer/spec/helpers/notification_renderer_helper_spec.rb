# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe NotificationRendererHelper, type: :helper do
  describe 'render_notifications' do
    it 'renders notifications using default renderer' do
      notification1 =
        create_title_and_content_notification('title1', 'content1')
      notification2 =
        create_title_and_content_notification('title2', 'content2')

      rendered = helper.render_notifications([notification1, notification2])

      expect(rendered).to eq(
        '<div class="notification-renderer notifications"><div>title1: '\
        'content1</div><div>title2: content2</div></div>'
      )
    end
  end
end

def create_title_and_content_notification(title, content)
  Notification.create(type: 'title_and_content',
                      metadata: { title: title, content: content })
end
