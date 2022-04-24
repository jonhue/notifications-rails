# frozen_string_literal: true

require_relative 'rails_helper'

RSpec.describe NotificationHandler do
  describe 'baseline' do
    it 'only loaded the absolute minimum dependencies ' \
       'so we can test in isolation' do
      # rubocop:disable RSpec/DescribedClass
      expect(defined?(NotificationHandler)).to  eq 'constant'
      # rubocop:enable RSpec/DescribedClass
      expect(defined?(NotificationPusher)).to   be_nil
      expect(defined?(NotificationRenderer)).to be_nil
      expect(defined?(NotificationSettings)).to be_nil
    end
  end
end
