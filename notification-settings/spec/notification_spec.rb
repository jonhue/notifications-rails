# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationSettings::NotificationLibrary, type: :model do
  it 'requires a target' do
    notification = Notification.new
    expect(notification.valid?).to eq false
    expect(notification.errors[:target]).to eq ["can't be blank"]
    expect(notification.save).to eq false
    expect(notification).not_to be_persisted

    notification.target = user
    notification.save
    expect(notification).to be_persisted
  end
end
