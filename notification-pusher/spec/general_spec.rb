# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationPusher do
  describe 'baseline' do
    it 'only loaded the absolute minimum dependencies so we can test using in isolation' do
      expect(defined?(NotificationHandler )).to eq 'constant'
      expect(defined?(NotificationPusher  )).to eq 'constant' # rubocop:disable RSpec/DescribedClass
      expect(defined?(NotificationRenderer)).to be_nil
      expect(defined?(NotificationSettings)).to be_nil
    end
  end
end
