# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationHandler::NotificationLib do
  let(:recipe) { build_stubbed :recipe }
  let(:user)   { build_stubbed :user }

  it 'can store an object' do
    notification = create :notification, target: user, object: recipe

    expect(notification.object).to eq recipe
  end

  it 'can store metadata' do
    notification = create :notification, target: user,
                                         metadata: {
                                           title: 'My first notification',
                                           content: "It looks great, doesn't it?"
                                         }

    expect(notification.metadata).to eq(
      title: 'My first notification',
      content: "It looks great, doesn't it?"
    )
  end

  describe '#read/#unread' do
    let(:notification) { build_stubbed :notification, target: user }

    it 'is unread by default' do
      expect(notification.read?).to   eq false
      expect(notification.unread?).to eq true
    end

    it 'can be marked as read' do
      notification.read = true
      expect(notification.read?).to   eq true
      expect(notification.unread?).to eq false
    end
  end

  describe 'sending to group' do
    let!(:user)            { create :user }
    let!(:subscribed_user) { create :user, subscriber: true }
    let!(:notification)    { create :notification, group: :subscribers }

    it do
      expect(Notification.where(target: user).last.present?).to eq false
      expect(Notification.where(target: subscribed_user).last.present?).to eq true
      expect(Notification.where(target: nil).last.present?).to eq false
    end
  end
end
