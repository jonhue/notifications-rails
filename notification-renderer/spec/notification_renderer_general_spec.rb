# frozen_string_literal: true

require_relative 'rails_helper'

RSpec.describe NotificationRenderer do
  describe 'baseline' do
    it 'only loaded the absolute minimum dependencies ' \
       'so we can test in isolation' do
      expect(defined?(NotificationHandler)).to  eq 'constant'
      expect(defined?(NotificationPusher)).to   eq nil
      # rubocop:disable RSpec/DescribedClass
      expect(defined?(NotificationRenderer)).to eq 'constant'
      # rubocop:enable RSpec/DescribedClass
      expect(defined?(NotificationSettings)).to eq nil
    end
  end
end
