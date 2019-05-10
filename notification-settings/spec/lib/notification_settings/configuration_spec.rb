# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/notification_settings/configuration'

RSpec.describe NotificationSettings::Configuration do
  let(:config) { NotificationSettings.configuration }

  it 'allows configuring the gem' do
    NotificationSettings.configure do |config|
      config.default_category       = :my_category
      config.last_seen              = :last_activity
      config.idle_after             = 30.minutes
      config.offline_after          = 6.hours
      config.do_not_notify_statuses = ['do not disturb']
      config.do_not_push_statuses   = ['do not disturb', 'focus']
    end

    expect(config.default_category).to       eq :my_category
    expect(config.last_seen).to              eq :last_activity
    expect(config.idle_after).to             eq 30.minutes
    expect(config.offline_after).to          eq 6.hours
    expect(config.do_not_notify_statuses).to eq ['do not disturb']
    expect(config.do_not_push_statuses).to   eq ['do not disturb', 'focus']
  end
end
