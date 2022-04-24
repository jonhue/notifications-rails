# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationPusher::NotificationLib do
  let(:some_pusher) do
    instance_double(NotificationPusher::DeliveryMethodConfiguration)
  end
  let(:other_pusher) do
    instance_double(NotificationPusher::DeliveryMethodConfiguration)
  end

  describe '#deliver' do
    let(:notification) { build_stubbed :notification }

    it 'passes the options stored in the configuration' do
      expect(NotificationPusher::DeliveryMethod::Null)
        .to receive(:new).with(notification, some_option: :value)
                         .and_call_original

      notification.deliver(:null)
    end

    it 'returns false when given nil' do
      expect(notification.deliver(nil)).to be false
    end

    it 'gives a useful error when given an invalid name' do
      expect { notification.deliver(:unknown) }
        .to raise_error(
          ArgumentError,
          'Could not find a registered delivery method for :unknown. ' \
          'Make sure you register it with ' \
          'config.register_delivery_method :unknown, :CustomDeliveryMethod'
        )
    end

    it 'when no options passed' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, {})

      notification.deliver(:some_pusher)
    end

    it 'when options passed' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, some: 1)

      notification.deliver(:some_pusher, some: 1)
    end

    it 'when multiple pushers with distinct options are specified' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:other_pusher).and_return(other_pusher)
      expect(some_pusher).to  receive(:call).with(notification, some: 1)
      expect(other_pusher).to receive(:call).with(notification, other: 1)

      notification.deliver(
        [:some_pusher, :other_pusher],
        some_pusher: { some: 1 },
        other_pusher: { other: 1 }
      )
    end

    it 'does not cause duplicate delivery from after_create_commit ' \
       'when called inside a transaction' do
      allow(NotificationPusher::DeliveryMethod::Null)
        .to receive(:new).once.and_call_original

      User.transaction do
        notification = create :notification
        notification.deliver(:null)
      end
    end
  end

  describe 'specifying delivery method via attributes' do
    let(:notification) { build :notification }

    it 'when no options passed' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, {})

      notification.update!(delivery_method: :some_pusher)
    end

    it 'when options passed' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, some: 1)

      notification.update!(
        delivery_method: :some_pusher,
        delivery_options: { some: 1 }
      )
    end

    it 'when multiple delivery methods with distinct options are specified' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:other_pusher).and_return(other_pusher)
      expect(some_pusher).to  receive(:call).with(notification, some: 1)
      expect(other_pusher).to receive(:call).with(notification, other: 1)

      notification.update!(
        delivery_method: [:some_pusher, :other_pusher],
        delivery_options: {
          some_pusher: { some: 1 },
          other_pusher: { other: 1 }
        }
      )
    end
  end

  describe 'User#notify' do
    let(:user) { build_stubbed :user }

    it 'when no options passed' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      expect(some_pusher)
        .to receive(:call).with(instance_of(Notification), {})

      user.notify(delivery_method: :some_pusher)
    end

    it 'when options passed' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      expect(some_pusher)
        .to receive(:call).with(instance_of(Notification), some: 1)

      user.notify(delivery_method: :some_pusher,
                  delivery_options: { some: 1 })
    end

    it 'when multiple pushers with distinct options are specified' do
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:some_pusher).and_return(some_pusher)
      allow(NotificationPusher::DeliveryMethodConfiguration)
        .to receive(:find_by_name!).with(:other_pusher).and_return(other_pusher)
      expect(some_pusher)
        .to receive(:call).with(instance_of(Notification), some: 1)
      expect(other_pusher)
        .to receive(:call).with(instance_of(Notification), other: 1)

      user.notify(
        delivery_method: [:some_pusher, :other_pusher],
        delivery_options: {
          some_pusher: { some: 1 },
          other_pusher: { other: 1 }
        }
      )
    end
  end
end
