# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationSettings::NotificationLib do
  let(:notification) { build_stubbed :notification, category: :my_category }
  let(:user)         { notification.target }
  let(:setting)      { user.notification_setting }

  it 'requires a target' do
    notification = Notification.new
    expect(notification.valid?).to eq false
    expect(notification.errors[:target])
      .to eq ['must exist', "can't be blank"]
    expect(notification.save).to eq false
    expect(notification.persisted?).to eq false

    notification.target = user
    notification.save
    expect(notification.persisted?).to eq true
  end

  describe ':enabled' do
    it 'is considered enabled by default' do
      expect(setting[:enabled]).to eq nil
      expect(notification.creation_allowed?).to eq true
      expect(user.notify.persisted?).to eq true
    end

    it 'when disabled' do
      setting.settings[:enabled] = false
      expect(notification.creation_allowed?).to eq false
      expect(user.notify.persisted?).to eq false
    end

    describe 'category_settings' do
      pending
    end
  end

  describe 'global (:pusher_enabled) settings' do
    it 'is considered enabled by default' do
      expect(setting[:pusher_enabled]).to eq nil

      expect(notification.push_allowed?(:Null)).to eq true
    end

    it 'when disabled' do
      setting.settings[:pusher_enabled] = false

      expect(notification.push_allowed?(:Null)).to eq false
    end

    it 'category_setting disabled' do
      setting.category_settings[:my_category] = {}
      setting.category_settings[:my_category][:pusher_enabled] = false

      expect(notification.category_setting).to eq(pusher_enabled: false)
      expect(notification.push_allowed?(:Null)).to eq false
    end
  end

  describe 'pusher-specific settings' do
    it 'is considered enabled by default' do
      expect(setting[:Null]).to eq nil

      expect(notification.push_allowed?(:Null)).to eq true
      expect(user.notify.persisted?).to eq true
    end

    it 'when disabled' do
      setting.settings[:Null] = false

      expect(notification.push_allowed?(:Null)).to eq false
    end

    it 'category_setting disabled' do
      setting.category_settings[:my_category] = {}
      setting.category_settings[:my_category][:Null] = false

      expect(notification.push_allowed?(:Null)).to eq false
    end

    it 'the enabled one still pushes with one pusher enabled ' \
       'and one disabled' do
      setting.category_settings[:my_category] = {}
      setting.category_settings[:my_category][:Null] = false
      setting.category_settings[:my_category][:SomePusher] = true

      expect(notification.push_allowed?(:Null)).to                eq false
      expect(notification.push_allowed?(:SomePusher)).to          eq true
      expect(notification.push_allowed?([:Null, :SomePusher])).to eq true
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

      describe 'in do_not_push_statuses' do
        it 'does not push'
      end
      # rubocop:enable RSpec/NestedGroups
    end
  end
end
