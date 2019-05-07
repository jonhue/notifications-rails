# frozen_string_literal: true

RSpec.describe NotificationSettings, 'status', type: :model do
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
    describe 'in do_not_notify_statuses' do
      it 'does not notify'
      it 'does not push'
    end

    describe 'in do_not_push_statuses' do
      it 'does not push'
    end
  end
end
