# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationSettings::Subscriber do
  let(:user)   { build_stubbed(:user) }
  let(:recipe) { build_stubbed(:recipe) }

  it 'subscribe' do
    user.subscribe(recipe)
    expect(user.notification_subscribables.present?).to be true
  end

  it 'unsubscribe' do
    user.subscribe(recipe)
    user.unsubscribe(recipe)
    expect(user.notification_subscribables.reload.empty?).to be true
  end
end
