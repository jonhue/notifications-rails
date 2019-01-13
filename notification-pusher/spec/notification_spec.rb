# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationPusher::NotificationLibrary, type: :model do
  let(:pusher_double) { double('pusher') } # rubocop:disable RSpec/VerifiedDoubles

  describe '#push' do
    let(:notification) { create_notification }

    it 'passes the options stored in the configuration' do
      expect(NotificationPusher::Null).to receive(:new).with(
        instance_of(Notification),
        some_option: :value
      )
      notification.push :Null
    end

    context 'when given nil' do
      it 'gives a useful error' do
        expect do
          notification.push nil
        end.to raise_error ArgumentError, 'Expected a pusher or array of pushers but got nil'
      end
    end

    context 'when given an invalid name' do
      it 'gives a useful error' do
        expect do
          notification.push :Unknown
        end.to raise_error(ArgumentError, 'Could not find a registered pusher for Unknown. ' \
          'Make sure you register it with config.define_pusher :Unknown')
      end
    end

    describe 'when no options passed' do
      it do
        expect_pusher
        notification.push :SomePusher
      end
    end

    describe 'when options passed' do
      it do
        expect_pusher notification, some: 1
        notification.push :SomePusher, some: 1
      end
    end

    describe 'when multiple pushers specified, each with options' do
      it do
        expect_multiple_pushers_each_with_options(notification)
        notification.push [:SomePusher, :OtherPusher],
                          SomePusher: { some: 1 }, OtherPusher: { other: 1 }
      end
    end

    context 'called inside a transaction' do
      xit "doesn't cause duplicate push from after_create_commit" do
        expect(NotificationPusher::Null).to receive(:new).once
        User.transaction do
          notification = create_notification
          notification.push :Null
        end # <- The after_create_commit is triggered here
      end
    end
  end

  describe 'specifying pusher via attributes' do
    let(:notification) { build_notification }

    describe 'when no options passed' do
      it do
        expect_pusher
        notification.update_attributes(pusher: :SomePusher)
      end
    end

    describe 'when options passed' do
      it do
        expect_pusher notification, some: 1
        notification.update_attributes(
          pusher: :SomePusher,
          pusher_options: { some: 1 }
        )
      end
    end

    describe 'when multiple pushers specified, each with options' do
      it do
        expect_multiple_pushers_each_with_options(notification)
        notification.update_attributes(
          pusher: [:SomePusher, :OtherPusher],
          pusher_options: { SomePusher: { some: 1 }, OtherPusher: { other: 1 } }
        )
      end
    end
  end

  describe 'User#notify' do
    describe 'when options passed' do
      it do
        expect_pusher instance_of(Notification), some: 1
        user.notify(pusher: :SomePusher,
                    pusher_options: { some: 1 })
      end
    end

    describe 'when multiple pushers specified, each with options' do
      it do
        expect_multiple_pushers_each_with_options
        user.notify(pusher: [:SomePusher, :OtherPusher],
                    pusher_options: { SomePusher: { some: 1 }, OtherPusher: { other: 1 } })
      end
    end
  end

  def expect_pusher_find(name, pusher)
    expect(NotificationPusher::Pusher).to receive(:find_by_name!).with(name).and_return(pusher)
  end

  def expect_pusher(notification = instance_of(Notification), expected_options = {})
    pusher = pusher_double
    expect_pusher_find(:SomePusher, pusher)
    expect(pusher).to receive(:call).with(notification, expected_options)
  end

  def expect_multiple_pushers_each_with_options(notification = instance_of(Notification))
    some_pusher  = double('pusher') # rubocop:disable RSpec/VerifiedDoubles
    other_pusher = double('pusher') # rubocop:disable RSpec/VerifiedDoubles
    expect_pusher_find(:SomePusher,  some_pusher)
    expect_pusher_find(:OtherPusher, other_pusher)
    expect(some_pusher ).to receive(:call).with(notification, some: 1)
    expect(other_pusher).to receive(:call).with(notification, other: 1)
  end
end
