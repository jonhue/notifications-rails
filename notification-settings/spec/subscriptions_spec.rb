# frozen_string_literal: true

require 'rails_helper'

# Tests both:
# - NotificationSettings::Subscriber
# - NotificationSettings::Subscribable
# Documentation: https://github.com/jonhue/notifications-rails/tree/master/notification-settings#subscriptions
#
RSpec.describe NotificationSettings, 'Subscriptions', type: :model do
  let(:recipe) { Recipe.create! }

  describe NotificationSettings::Subscriber do
    it 'subscribe' do
      user.subscribe(recipe)
      expect(user.notification_subscriptions).to be_present
    end
    it 'unsubscribe' do
      user.subscribe(recipe)
      user.unsubscribe(recipe)
      expect(user.notification_subscriptions.reload).to be_empty
    end
  end

  describe NotificationSettings::Subscribable do
    describe '#notify_subscribers' do
      context 'when notification_dependents is present' do
        context 'overriding dependents: nil' do
          pending
        end
      end
    end
  end
end
