# frozen_string_literal: true

require_relative 'rails_helper'

RSpec.describe NotificationPusher do
  describe 'baseline' do
    it 'only loaded the absolute minimum dependencies ' \
       'so we can test in isolation' do
      expect(defined?(NotificationHandler)).to  eq 'constant'
      # rubocop:disable RSpec/DescribedClass
      expect(defined?(NotificationPusher)).to   eq 'constant'
      # rubocop:enable RSpec/DescribedClass
      expect(defined?(NotificationRenderer)).to be_nil
      expect(defined?(NotificationSettings)).to be_nil
    end
  end
end
