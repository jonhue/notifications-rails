# frozen_string_literal: true

# Do not load Rails for this test
require 'spec_helper'
# Note: Even though *this* test doesn't load Rails, if run as part of a full test suite, *other*
# tests may have already loaded Rails by the time the tests in this file are run. Since I don't know
# of a reliable way to *unload* Rails and anything it has loaded, the only way to properly test that
# things work correctly *without* having loaded all initializers, etc. is to run this test in its
# own test run. You can run:
#   bundle exec rspec --exclude-pattern 'spec/without_rails/**/*_spec.rb'
# to run all tests that are expected to be run without Rails loaded. We are using that in
# bin/test_all.

RSpec.describe NotificationPusher::Configuration do
  around do |example|
    # Skip these tests if Rails is already loaded so we don't get test failures if this file gets
    # loaded as part of a test suite that loaded Rails.
    unless defined?(::Combustion)
      example.run
    end
  end

  context 'by default (without having called configure)' do
    xit do
      # https://github.com/jonhue/notifications-rails/issues/56
      expect(NotificationSettings.configuration).to be_a described_class
    end
  end

  describe '.configure' do
    it do
      if NotificationPusher.configuration
        orig_pushers = NotificationPusher.configuration.pushers
      end
      NotificationPusher.configure do |config|
        config.pushers = 'something_else'
      end
      expect(NotificationPusher.configuration).to be_a described_class
      expect(NotificationPusher.configuration.pushers).to eq 'something_else'
    ensure
      NotificationPusher.configuration.pushers = orig_pushers
    end
  end

  describe '#define_pusher' do
    pending
  end
end
