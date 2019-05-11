# frozen_string_literal: true

require_relative '../../rails_helper'

RSpec.describe NotificationSettings::Subscribable do
  let(:recipe) { create :recipe }

  describe '#notify_subscribers' do
    context 'when notification_dependents is present' do
      # rubocop:disable RSpec/NestedGroups
      context 'when overriding dependents: nil' do
        pending
      end
      # rubocop:enable RSpec/NestedGroups
    end
  end
end
