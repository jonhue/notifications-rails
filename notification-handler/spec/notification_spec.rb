# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationHandler::NotificationLibrary, type: :model do
  let(:recipe) { Recipe.create! }

  it 'can store an object' do
    notification = create_notification(object: recipe)
    notification = Notification.find(notification.id)
    expect(notification.object).to eq recipe
  end

  it 'can store metadata' do
    notification = Notification.new(target: user)
    notification.metadata = {
      title: 'My first notification',
      content: "It looks great, doesn't it?"
    }
    notification.save!
    notification = Notification.find(notification.id)
    expect(notification.metadata).to eq(
      title: 'My first notification',
      content: "It looks great, doesn't it?"
    )
  end

  describe '#read/#unread' do
    it 'is unread by default' do
      expect(notification.read?  ).to eq false
      expect(notification.unread?).to eq true

      expect(Notification.read  ).to eq []
      expect(Notification.unread).to eq [notification]
    end
    it 'can be marked as read' do
      notification.read = true
      expect(notification.read?  ).to eq true
      expect(notification.unread?).to eq false

      notification.save!
      expect(Notification.read  ).to eq [notification]
      expect(Notification.unread).to eq []
    end
  end
end
