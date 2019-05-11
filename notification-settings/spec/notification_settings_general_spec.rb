# frozen_string_literal: true

require_relative 'rails_helper'

RSpec.describe NotificationSettings do
  describe 'baseline' do
    it 'only loaded the absolute minimum dependencies ' \
       'so we can test in isolation' do
      expect(defined?(NotificationHandler)).to  eq 'constant'
      expect(defined?(NotificationPusher)).to   eq nil
      expect(defined?(NotificationRenderer)).to eq nil
      # rubocop:disable RSpec/DescribedClass
      expect(defined?(NotificationSettings)).to eq 'constant'
      # rubocop:enable RSpec/DescribedClass
    end
  end
end
