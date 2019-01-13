# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationHandler::Target, type: :model do
  describe '#notify' do
    it 'returns the notification' do
      expect(user.notify).to be_a Notification
    end

    it 'creates a Notification record' do
      notification = user.notify
      expect(notification).to be_valid
      expect(notification).to be_persisted
      expect(user.notifications).to include notification
    end
  end
end
