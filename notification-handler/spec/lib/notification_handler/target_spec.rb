# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationHandler::Target do
  let(:user) { build_stubbed(:user) }

  describe '#notify' do
    it 'returns the notification' do
      expect(user.notify).to be_a Notification
    end

    it 'creates a Notification record' do
      notification = user.notify
      expect(notification.valid?).to     be true
      expect(notification.persisted?).to be true
      expect(user.notifications).to      include notification
    end
  end
end
