# frozen_string_literal: true

require_relative 'rails_helper'

RSpec.describe NotificationRenderer do
  describe 'baseline' do
    it 'only loaded the absolute minimum dependencies ' \
       'so we can test in isolation' do
      expect(defined?(NotificationHandler)).to  eq 'constant'
      expect(defined?(NotificationPusher)).to   be_nil
      # rubocop:disable RSpec/DescribedClass
      expect(defined?(NotificationRenderer)).to eq 'constant'
      # rubocop:enable RSpec/DescribedClass
      expect(defined?(NotificationSettings)).to be_nil
    end
  end
end
