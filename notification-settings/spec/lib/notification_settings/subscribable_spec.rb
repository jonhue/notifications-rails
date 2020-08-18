# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationSettings::Subscribable do
  let(:recipe) { create :recipe }
  let(:user1)  { create :user }
  let(:user2)  { create :user }

  describe '#notify_subscribers' do
    before do
      user1.subscribe(recipe)
      user2.subscribe(recipe)
    end

    it 'notifies subscribers' do
      expect { recipe.notify_subscribers(metadata: { some: 1 }) }
        .to  change { user1.notifications.reload.size }.by(1)
        .and change { user2.notifications.reload.size }.by(1)

      expect(user1.notifications.last)
        .to eq Notification.find_by(target: user1, object: recipe,
                                    metadata: { some: 1 })
      expect(user2.notifications.last)
        .to eq Notification.find_by(target: user2, object: recipe,
                                    metadata: { some: 1 })
    end

    # rubocop:disable RSpec/EmptyExampleGroup
    context 'when notification_dependents is present' do
      # rubocop:disable RSpec/NestedGroups
      context 'when overriding dependents: nil' do
        pending
      end
      # rubocop:enable RSpec/NestedGroups
    end
    # rubocop:enable RSpec/EmptyExampleGroup
  end
end
