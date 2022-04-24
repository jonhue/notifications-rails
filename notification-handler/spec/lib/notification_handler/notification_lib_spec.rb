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
    notification = create :notification,
                          target: user,
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
      expect(notification.read?).to   be false
      expect(notification.unread?).to be true
    end

    it 'can be marked as read' do
      notification.read = true
      expect(notification.read?).to   be true
      expect(notification.unread?).to be false
    end
  end

  describe 'sending to group' do
    let!(:user)            { create :user }
    let!(:subscribed_user) { create :user, subscriber: true }

    context 'without args' do
      it do
        expect { Notification.for_group(:subscribers) }
          .to  change { subscribed_user.notifications.reload.size }.by(1)
          .and change { user.notifications.reload.size }.by(0)
      end
    end

    context 'with one arg' do
      it do
        expect { Notification.for_group(:subscribed, args: [false]) }
          .to  change { user.notifications.reload.size }.by(1)
          .and change { subscribed_user.notifications.reload.size }.by(0)
      end
    end

    context 'with multiple args' do
      let!(:foo) { create :user, name: 'Foo' }

      it do
        expect do
          Notification.for_group(:subscribed_and_starts_with,
                                 args: [false, 'F'])
        end.to change { foo.notifications.reload.size }.by(1)
      end
    end
  end
end
