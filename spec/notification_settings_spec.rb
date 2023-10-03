# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationSettings do
  let(:notification) { build_stubbed(:notification, category: :my_category) }
  let(:settings)     { notification.target.settings }

  describe 'global pusher settings' do
    it 'is enabled by default' do
      expect(settings.delivery_methods_.enabled).to be_nil
      expect(NotificationPusher::DeliveryMethod::Null)
        .to receive(:new).with(notification, { some_option: :value })
                         .and_call_original

      notification.deliver(:null)
    end

    it 'does not call the pusher when disabled globally' do
      settings.delivery_methods!.enabled = false

      expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

      notification.deliver(:null)
    end

    it 'does not call the pusher when disabled for category' do
      settings.categories!.my_category!.delivery_methods!.enabled = false

      expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

      notification.deliver(:null)
    end
  end

  describe 'pusher-specific settings' do
    it 'is enabled by default' do
      expect(settings.delivery_methods_.null).to be_nil
      expect(NotificationPusher::DeliveryMethod::Null)
        .to receive(:new).with(notification, { some_option: :value })
                         .and_call_original

      notification.deliver(:null)
    end

    it 'does not call the pusher when disabled globally' do
      settings.delivery_methods!.null = false

      expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

      notification.deliver(:null)
    end

    it 'does not call the pusher when disabled for category' do
      settings.categories!.my_category!.delivery_methods!.null = false

      expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)

      notification.deliver(:null)
    end

    it 'only pushes enabled when one enabled and one disabled is passed' do
      settings.categories!.my_category!.delivery_methods!.null = false
      settings.categories!.my_category!.delivery_methods!.some_pusher = true

      expect(NotificationPusher::DeliveryMethod::Null).not_to receive(:new)
      expect(NotificationPusher::DeliveryMethod::SomePusher)
        .to receive(:new).and_call_original

      notification.deliver([:null, :some_pusher])
    end
  end
end
