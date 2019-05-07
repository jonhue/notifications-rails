# frozen_string_literal: true

require 'rails_helper'

# Documentation: https://github.com/jonhue/notifications-rails/tree/master/notification-settings#settings
#
RSpec.describe NotificationSettings, ':enabled', type: :model do
  context 'by default' do
    it 'is considered enabled' do
      setting = user.notification_setting
      expect(setting[:enabled]).to be_nil
      expect(notification.send(:settings_allow_create?)).to eq true
      expect(user.notify.persisted?).to eq true
    end
  end

  context 'when disabled' do
    it do
      setting = user.notification_setting
      setting.settings[:enabled] = false
      expect(notification.send(:settings_allow_create?)).to eq false
      expect(user.notify.persisted?).to eq false
    end
  end

  describe 'category_settings' do
    pending
  end
end
