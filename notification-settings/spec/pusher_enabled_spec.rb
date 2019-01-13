# frozen_string_literal: true

require 'rails_helper'

# Documentation: https://github.com/jonhue/notifications-rails/tree/master/notification-settings#pusher-specific-settings
#
# See also: ../spec/pusher_enabled_spec.rb
#
RSpec.describe NotificationSettings, ':pusher_enabled', type: :model do
  let(:notification) { create_notification(category: :my_category) }

  describe 'global (:pusher_enabled) settings' do
    context 'by default' do
      it 'is considered enabled' do
        setting = user.notification_setting
        expect(setting[:pusher_enabled]).to be_nil
        expect(notification.send(:settings_allow_push?, :Null)).to eq true
        expect(notification.send(:can_use_pusher?,      :Null)).to eq true
      end
    end

    context 'when disabled' do
      it do
        setting = user.notification_setting
        setting.settings[:pusher_enabled] = false
        expect(notification.send(:settings_allow_push?, :Null)).to eq false
        expect(notification.send(:can_use_pusher?,      :Null)).to eq false
      end
    end

    context 'category_setting disabled' do
      it do
        setting = user.notification_setting
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:pusher_enabled] = false
        expect(notification.send(:category_setting)).to eq(pusher_enabled: false)
        expect(notification.send(:global_category_settings_allow_push?)).to eq false
        expect(notification.send(:category_settings_allow_push?, :Null)).to eq false
        expect(notification.send(:can_use_pusher?,               :Null)).to eq false
        expect(notification.send(:can_push?,                     :Null)).to eq false
      end
    end
  end

  describe 'pusher-specific settings' do
    context 'by default' do
      it 'is considered enabled' do
        setting = user.notification_setting
        expect(setting[:Null]).to be_nil
        expect(notification.send(:settings_allow_push?, :Null)).to eq true
        expect(notification.send(:can_use_pusher?,      :Null)).to eq true
        expect(notification.send(:can_push?,            :Null)).to eq true
        expect(user.notify.persisted?).to eq true
      end
    end

    context 'when disabled' do
      it do
        setting = user.notification_setting
        setting.settings[:Null] = false
        expect(notification.send(:settings_allow_push?, :Null)).to eq false
        expect(notification.send(:can_use_pusher?,      :Null)).to eq false
        expect(notification.send(:can_push?,            :Null)).to eq false
      end
    end

    context 'category_setting disabled' do
      it do
        setting = user.notification_setting
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:Null] = false
        expect(notification.send(:local_category_settings_allow_push?, :Null)).to eq false
        expect(notification.send(:category_settings_allow_push?,       :Null)).to eq false
        expect(notification.send(:can_use_pusher?,                     :Null)).to eq false
        expect(notification.send(:can_push?,                           :Null)).to eq false
      end
    end

    context 'one pusher enabled, one disabled' do
      it 'the enabled one still pushes' do
        setting = user.notification_setting
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:Null] = false
        setting.category_settings[:my_category][:SomePusher] = true
        expect(notification.send(:local_category_settings_allow_push?, :Null)).to eq false
        expect(notification.send(:category_settings_allow_push?,       :Null)).to eq false
        expect(notification.send(:can_use_pusher?,                     :Null)).to eq false
        expect(notification.send(:can_push?,                           :Null)).to eq false
        expect(notification.send(:local_category_settings_allow_push?, :SomePusher)).to eq true
        expect(notification.send(:category_settings_allow_push?,       :SomePusher)).to eq true
        expect(notification.send(:can_use_pusher?,                     :SomePusher)).to eq true
        expect(notification.send(:can_push?,                           :SomePusher)).to eq true
        expect(notification.send(:can_use_pushers?, [:Null, :SomePusher])).to eq true
        expect(notification.send(:can_push?,        [:Null, :SomePusher])).to eq true
      end
    end
  end
end
