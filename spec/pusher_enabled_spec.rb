# frozen_string_literal: true

require 'rails_helper'

# Documentation: https://github.com/jonhue/notifications-rails/tree/master/notification-settings#pusher-specific-settings
#
# Similar to notification-settings/spec/pusher_enabled_spec.rb except we actually verify that it
# doesn't call the pusher when we push and the pusher is disabled.
#
RSpec.describe NotificationSettings, ':pusher_enabled', type: :model do
  let(:notification) { create_notification(category: :my_category) }

  describe 'global (:pusher_enabled) settings' do
    context 'by default' do
      it 'is considered enabled' do
        setting = user.notification_setting
        expect(setting[:pusher_enabled]).to be_nil
        expect(NotificationPusher::Null).to receive(:new).and_call_original
        notification.push :Null
      end
    end

    context 'when disabled' do
      it do
        setting = user.notification_setting
        setting.settings[:pusher_enabled] = false
        expect(NotificationPusher::Null).not_to receive(:new)
        notification.push :Null
      end
    end

    context 'category_setting disabled' do
      it do
        setting = user.notification_setting
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:pusher_enabled] = false
        expect(NotificationPusher::Null).not_to receive(:new)
        notification.push :Null
      end
    end
  end

  describe 'pusher-specific settings' do
    context 'by default' do
      it 'is considered enabled' do
        setting = user.notification_setting
        expect(setting[:Null]).to be_nil
        expect(NotificationPusher::Null).to receive(:new).and_call_original
        notification.push :Null
      end
    end

    context 'when disabled' do
      it do
        setting = user.notification_setting
        setting.settings[:Null] = false
        expect(NotificationPusher::Null).not_to receive(:new)
        notification.push :Null
      end
    end

    context 'category_setting disabled' do
      it do
        setting = user.notification_setting
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:Null] = false
        expect(NotificationPusher::Null).not_to receive(:new)
        notification.push :Null
      end
    end

    context 'one pusher enabled, one disabled' do
      it 'the enabled one still pushes' do
        setting = user.notification_setting
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:Null] = false
        setting.category_settings[:my_category][:SomePusher] = true
        expect(NotificationPusher::Null).not_to receive(:new)
        expect(NotificationPusher::SomePusher).to receive(:new).and_call_original
        notification.push [:Null, :SomePusher]
      end
    end
  end
end
