# frozen_string_literal: true

require_relative 'rails_helper'

RSpec.describe NotificationHandler do
  describe 'baseline' do
    it 'only loaded the absolute minimum dependencies so we can test using in isolation' do
      expect(defined?(NotificationHandler)).to  eq 'constant'
      expect(defined?(NotificationPusher)).to   eq nil
      expect(defined?(NotificationRenderer)).to eq nil
      expect(defined?(NotificationSettings)).to eq nil
    end
  end
end
