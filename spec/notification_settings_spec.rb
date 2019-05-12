# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationSettings do
  let(:notification) { build_stubbed :notification, category: :my_category }
  let(:setting)      { notification.target.notification_setting }

  describe ':delivery_method_enabled' do
    describe 'global settings' do
      it 'is enabled by default' do
        expect(setting[:delivery_method_enabled]).to eq nil
        expect(NotificationPusher::DeliveryMethod::Null)
          .to receive(:new).with(notification, some_option: :value)
                           .and_call_original

        notification.deliver(:Null)
      end

      it 'does not call the pusher when disabled globally' do
        setting.settings[:delivery_method_enabled] = false

        expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

        notification.deliver(:Null)
      end

      it 'does not call the pusher when disabled for category' do
        setting.category_settings[:my_category] = {}
        setting
          .category_settings[:my_category][:delivery_method_enabled] = false

        expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

        notification.deliver(:Null)
      end
    end

    describe 'pusher-specific settings' do
      it 'is enabled by default' do
        expect(setting[:Null]).to eq nil
        expect(NotificationPusher::DeliveryMethod::Null)
          .to receive(:new).with(notification, some_option: :value)
                           .and_call_original

        notification.deliver(:Null)
      end

      it 'does not call the pusher when disabled globally' do
        setting.settings[:Null] = false

        expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

        notification.deliver(:Null)
      end

      it 'does not call the pusher when disabled for category' do
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:Null] = false

        expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

        notification.deliver(:Null)
      end

      it 'only pushes enabled when one enabled and one disabled is passed' do
        setting.category_settings[:my_category] = {}
        setting.category_settings[:my_category][:Null] = false
        setting.category_settings[:my_category][:SomePusher] = true

        expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)
        expect(NotificationPusher::DeliveryMethod::SomePusher)
          .to receive(:new).and_call_original

        notification.deliver([:Null, :SomePusher])
      end
    end
  end
end
