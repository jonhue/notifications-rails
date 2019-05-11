# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationPusher::NotificationLib do
  let(:some_pusher)  { instance_double('Pusher') }
  let(:other_pusher) { instance_double('Pusher') }

  describe '#push' do
    let(:notification) { build_stubbed :notification }

    it 'passes the options stored in the configuration' do
      expect(NotificationPusher::Null)
        .to receive(:new).with(notification, some_option: :value)
                         .and_call_original

      notification.push(:Null)
    end

    it 'returns false when given nil' do
      expect(notification.push(nil)).to eq false
    end

    it 'gives a useful error when given an invalid name' do
      expect { notification.push(:Unknown) }
        .to raise_error(
          ArgumentError,
          'Could not find a registered pusher for Unknown. ' \
          'Make sure you register it with config.register_delivery_method :Unknown'
        )
    end

    it 'when no options passed' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, {})

      notification.push(:SomePusher)
    end

    it 'when options passed' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, some: 1)

      notification.push(:SomePusher, some: 1)
    end

    it 'when multiple pushers with distinct options are specified' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:OtherPusher).and_return(other_pusher)
      expect(some_pusher).to  receive(:call).with(notification, some: 1)
      expect(other_pusher).to receive(:call).with(notification, other: 1)

      notification.push(
        [:SomePusher, :OtherPusher],
        SomePusher: { some: 1 },
        OtherPusher: { other: 1 }
      )
    end

    it 'does not cause duplicate push from after_create_commit ' \
       'when called inside a transaction' do
      expect(NotificationPusher::Null).to receive(:new).once.and_call_original

      User.transaction do
        notification = create :notification
        notification.push(:Null)
      end
    end
  end

  describe 'specifying pusher via attributes' do
    let(:notification) { build :notification }

    it 'when no options passed' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, {})

      notification.update!(pusher: :SomePusher)
    end

    it 'when options passed' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(some_pusher).to receive(:call).with(notification, some: 1)

      notification.update!(
        pusher: :SomePusher,
        pusher_options: { some: 1 }
      )
    end

    it 'when multiple pushers with distinct options are specified' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:OtherPusher).and_return(other_pusher)
      expect(some_pusher).to  receive(:call).with(notification, some: 1)
      expect(other_pusher).to receive(:call).with(notification, other: 1)

      notification.update!(
        pusher: [:SomePusher, :OtherPusher],
        pusher_options: {
          SomePusher: { some: 1 },
          OtherPusher: { other: 1 }
        }
      )
    end
  end

  describe 'User#notify' do
    let(:user) { build_stubbed :user }

    it 'when no options passed' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(some_pusher)
        .to receive(:call).with(instance_of(Notification), {})

      user.notify(pusher: :SomePusher)
    end

    it 'when options passed' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(some_pusher)
        .to receive(:call).with(instance_of(Notification), some: 1)

      user.notify(pusher: :SomePusher,
                  pusher_options: { some: 1 })
    end

    it 'when multiple pushers with distinct options are specified' do
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:SomePusher).and_return(some_pusher)
      expect(NotificationPusher::Pusher)
        .to receive(:find_by_name!).with(:OtherPusher).and_return(other_pusher)
      expect(some_pusher)
        .to receive(:call).with(instance_of(Notification), some: 1)
      expect(other_pusher)
        .to receive(:call).with(instance_of(Notification), other: 1)

      user.notify(
        pusher: [:SomePusher, :OtherPusher],
        pusher_options: {
          SomePusher: { some: 1 },
          OtherPusher: { other: 1 }
        }
      )
    end
  end
end
