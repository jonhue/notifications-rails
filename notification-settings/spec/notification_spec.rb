# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationSettings::NotificationLibrary, type: :model do
  it 'requires a target' do
    notification = Notification.new
    expect do
      notification.save
    end.to raise_error(NoMethodError)
    # TODO: Check notification.errors [#50]
    expect(notification).not_to be_persisted

    notification.target = user
    notification.save
    expect(notification).to be_persisted
  end
end
