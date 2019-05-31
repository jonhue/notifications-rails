# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationSettings::NotificationLib do
  let(:notification) { build_stubbed :notification, category: :my_category }
  let(:user)         { notification.target }
  let(:settings)     { user.settings }

  context 'with persisted user' do
    let(:user) { create :user }

    it 'persists settings' do
      user.settings.enabled = true
      user.save

      expect(user.reload.settings.enabled?).to eq true
    end
  end

  it 'requires a target' do
    notification = Notification.new
    expect(notification.valid?).to eq false
    expect(notification.errors[:target])
      .to eq ['must exist']
    expect(notification.save).to eq false
    expect(notification.persisted?).to eq false

    notification.target = user
    notification.save
    expect(notification.persisted?).to eq true
  end

  describe 'global settings' do
    it 'is enabled by default' do
      expect(settings.enabled).to eq nil
      expect(notification.creation_allowed?).to eq true
      expect(user.notify.persisted?).to eq true
    end

    it 'can be disabled' do
      settings.enabled = false
      expect(notification.creation_allowed?).to eq false
      expect(user.notify.persisted?).to eq false
    end
  end

  describe 'global pusher settings' do
    it 'is enabled by default' do
      expect(settings.delivery_methods_.enabled).to eq nil

      expect(notification.delivery_allowed?(:null)).to eq true
    end

    it 'can be disabled' do
      settings.delivery_methods!.enabled = false

      expect(notification.delivery_allowed?(:null)).to eq false
    end
  end

  describe 'category-specific settings' do
    it 'is enabled by default'

    it 'can be disabled'

    it 'can disable all delivery methods' do
      settings.categories!.my_category!.delivery_methods!.enabled = false

      expect(notification.delivery_allowed?(:null)).to eq false
    end
  end

  describe 'delivery-method-specific settings' do
    it 'is enabled by default' do
      expect(settings.delivery_methods_.null).to eq nil

      expect(notification.delivery_allowed?(:null)).to eq true
      expect(user.notify.persisted?).to eq true
    end

    it 'can be disabled' do
      settings.delivery_methods!.null = false

      expect(notification.delivery_allowed?(:null)).to eq false
    end

    it 'the enabled one still pushes with one pusher enabled ' \
       'and one disabled' do
      settings.categories!.my_category!.delivery_methods!.null = false
      settings.categories!.my_category!.delivery_methods!.some_pusher = true

      expect(notification.delivery_allowed?(:null)).to                 eq false
      expect(notification.delivery_allowed?(:some_pusher)).to          eq true
      expect(notification.delivery_allowed?([:null, :some_pusher])).to eq true
    end
  end

  describe 'status' do
    describe 'online' do
      pending
    end

    describe 'idle' do
      pending
    end

    describe 'offline' do
      pending
    end

    describe 'custom status' do
      # rubocop:disable RSpec/NestedGroups
      describe 'in do_not_notify_statuses' do
        it 'does not notify'
        it 'does not push'
      end

      describe 'in do_not_deliver_statuses' do
        it 'does not push'
      end
      # rubocop:enable RSpec/NestedGroups
    end
  end
end
